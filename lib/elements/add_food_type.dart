import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/food.dart';
import 'package:marsyeats/data/type_food.dart';
import 'package:marsyeats/elements/input/info_input_widget.dart';
import 'package:marsyeats/servises/ingestions/foods.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';

class AddFoodType extends StatelessWidget {
  AddFoodType({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController packController = TextEditingController();
  final BehaviorSubject<bool> isPacked = BehaviorSubject.seeded(false);
  final BehaviorSubject<int> index = BehaviorSubject.seeded(0);

  @override
  Widget build(BuildContext context) {
    List<FoodType> foodTypes = context.watch<DataMeal>().getFoodTypes;
    return Container(
      padding: const EdgeInsets.all(8),
      child: SingleChildScrollView(
        child: StreamBuilder(
          stream: CombineLatestStream.list([
            isPacked.stream,
            index.stream,
          ]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
            return Column(
              children: [
                InfoInputWidget(
                  labelText: 'Название',
                  onChanged: (_) {},
                  controller: nameController,
                ),
                const SizedBox(height: 8),
                InfoInputWidget(
                  labelText: 'Калорийность на 100 грамм',
                  onChanged: (_) {},
                  controller: calorieController,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.arrow_left),
                      ),
                      onTap: () {
                        index.add((index.value - 1) % imageAssets.length);
                        imageController.text = '00${index.value + 1}.png';
                      },
                    ),
                    Image.asset(
                      'assets/images/${imageAssets[index.value]}',
                      width: MediaQuery.of(context).size.width / 3,
                    ),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(Icons.arrow_right),
                      ),
                      onTap: () {
                        index.add((index.value + 1) % imageAssets.length);
                        imageController.text = '00${index.value + 1}.png';
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  value: isPacked.value,
                  onChanged: (value) => isPacked.add(value ?? false),
                  title: Text('Порция часть пачки?'),
                ),
                if (isPacked.value) ...[
                  const SizedBox(height: 8),
                  InfoInputWidget(
                    labelText: 'Размер пачки (граммы)',
                    onChanged: (_) {},
                    controller: packController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ],
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: (nameController.text.isNotEmpty &&
                          imageController.text.isNotEmpty &&
                          (isPacked.value && int.tryParse(packController.text) != null) &&
                          int.tryParse(calorieController.text) != null)
                      ? () {
                          FoodService().addFoodType(
                            type: FoodType(
                              id: foodTypes.isNotEmpty ? foodTypes.last.id : 0,
                              title: nameController.text,
                              image: imageController.text,
                              calorie: int.parse(calorieController.text),
                              isPacked: isPacked.value,
                              packWeigth: isPacked.value ? int.parse(packController.text) : 0,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      : null,
                  child: Text('Добавить'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
