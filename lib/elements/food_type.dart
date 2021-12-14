import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/food.dart';
import 'package:provider/src/provider.dart';

import 'add_food_type.dart';

class FoodTypeSelect extends StatelessWidget {
  const FoodTypeSelect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataMeal dataMeal = context.read<DataMeal>();
    List<FoodType> foodTypes = context.watch<DataMeal>().getFoodTypes;
    FoodType? selectedType = context.watch<DataMeal>().selectedType;
    if (selectedType == null) {
      if (foodTypes.isNotEmpty) {
        selectedType = dataMeal.setSelectedType(foodTypes.first);
      }
    }
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: foodTypes.length + 1,
                itemBuilder: (context, index) {
                  if (foodTypes.length != index)
                    return InkWell(
                      onTap: () {
                        dataMeal.setSelectedType(foodTypes[index]);
                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          Radio<int>(
                            value: foodTypes[index].id,
                            groupValue: selectedType!.id,
                            onChanged: (_) {
                              dataMeal.setSelectedType(foodTypes[index]);
                              Navigator.pop(context);
                            },
                          ),
                          Text('${foodTypes[index].title}'),
                        ],
                      ),
                    );
                  return TextButton(
                    onPressed: () {
                      Navigator.maybePop(context);
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) {
                            return Scaffold(
                              body: SafeArea(
                                child: AddFoodType(),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Text('Добавить другое'),
                  );
                },
              ),
            );
          },
        );
      },
      child: selectedType != null
          ? Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                title: Text(selectedType.title),
                subtitle: selectedType.isPacked ? Text('${selectedType.packWeigth} грамм') : null,
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).dividerColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage(
                        'assets/images/${selectedType.image}',
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                trailing: const Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.grey,
                ),
              ),
            )
          : TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) {
                      return Scaffold(
                        body: SafeArea(
                          child: AddFoodType(),
                        ),
                      );
                    },
                  ),
                );
              },
              child: Text(
                'Добавить новый',
                style: TextStyle(color: Colors.lightGreenAccent[300]),
              ),
            ),
    );
  }
}
