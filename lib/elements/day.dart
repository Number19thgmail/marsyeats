import 'package:flutter/material.dart';
import 'package:marsyeats/data/oneMeal.dart';
import 'package:marsyeats/data/type_food.dart';
import 'package:marsyeats/elements/eatingFor24Hours.dart';
import 'package:marsyeats/elements/meal.dart';

class Day extends StatefulWidget {
  final List<OneMeal> meals;
  final String header;
  Day({@required this.meals, @required this.header});

  @override
  _DayState createState() => _DayState();
}

class _DayState extends State<Day> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    int weight = 0;
    widget.meals.forEach((element) {
      if (element.food == 'dry') {
        weight += int.parse(element.description);
      }
    });

    var meal = Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      direction: Axis.horizontal,
      children: <Meal>[
        ...widget.meals
            .map((value) => Meal(
                  id: value.docId,
                  descrition: value.description,
                  time: DateTime.parse(value.time),
                  type:
                      food.where((element) => element.type == value.food).first,
                  name: value.name,
                ))
            .toList(),
      ],
    );

    Widget info() {
      return Container(
        margin: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            meal,
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.white60,
        elevation: 10,
        child: Column(
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
              child: EatingFor24Hours.builder(
                weight: weight,
                title: widget.header,
              ),
              onPressed: () {
                setState(() {
                  show = !show;
                });
              },
            ),
            show ? info() : SizedBox(height: 0),
          ],
        ),
      ),
    );
  }
}
