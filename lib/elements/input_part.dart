import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/food.dart';
import 'package:marsyeats/elements/input/info_input_widget.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';

class InputPart extends StatefulWidget {
  InputPart({Key? key}) : super(key: key);

  @override
  State<InputPart> createState() => _InputPartState();
}

class _InputPartState extends State<InputPart> {
  final BehaviorSubject<double> part = BehaviorSubject.seeded(0);

  @override
  void dispose() {
    part.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FoodType? selectedType = context.watch<DataMeal>().selectedType;
    DataMeal data = context.read<DataMeal>();
    data.setWeigthPart(part.value);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        children: [
          Text('Какая часть пачки?'),
          const SizedBox(height: 8),
          StreamBuilder<double>(
            stream: part.stream,
            builder: (context, snapshot) {
              data.setWeigthPart(part.value);
              return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CirclePart(1, 2, part),
                  CirclePart(1, 3, part),
                  CirclePart(1, 4, part),
                  GestureDetector(
                    onTap: () {
                      TextEditingController numerator = TextEditingController();
                      TextEditingController denominator = TextEditingController();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Какая часть пачки из ${selectedType?.packWeigth} дана?'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InfoInputWidget(
                                  onChanged: (_) {},
                                  controller: numerator,
                                  labelText: 'Числитель',
                                ),
                                const SizedBox(height: 8),
                                InfoInputWidget(
                                  onChanged: (_) {},
                                  controller: denominator,
                                  labelText: 'Знаменатель',
                                ),
                              ],
                            ),
                            actions: [
                              CupertinoDialogAction(
                                child: Text('Применить'),
                                onPressed: () {
                                  int num = int.parse(numerator.text);
                                  double den = double.parse(denominator.text);
                                  double val = ((num/den)*100).round()/100;
                                  part.add(val);
                                  Navigator.pop(context);
                                },
                              ),
                              CupertinoDialogAction(
                                child: Text('Отмена'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: ([1 / 2, 1 / 3, 1 / 4].contains(part.value))  ? Colors.blueAccent : Colors.amber,
                      child: Text(([1 / 2, 1 / 3, 1 / 4].contains(part.value)) ? '...' : '${part.value}'),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class CirclePart extends StatelessWidget {
  final int numerator;
  final int denominator;
  final BehaviorSubject<double> value;
  const CirclePart(
    this.numerator,
    this.denominator,
    this.value, {
    Key? key,
  }) : super(key: key);
  double get currentValue => (numerator / denominator);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        value.add(currentValue);
      },
      child: CircleAvatar(
        backgroundColor: value.value == currentValue ? Colors.amber : Colors.blueAccent,
        child: Text('$numerator/$denominator'),
      ),
    );
  }
}
