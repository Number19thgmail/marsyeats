import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/ingestion.dart';
import 'package:marsyeats/elements/eatingFor24Hours.dart';
import 'package:marsyeats/elements/meal.dart';
import 'package:provider/src/provider.dart';
import 'package:rxdart/rxdart.dart';

class Day extends StatefulWidget {
  final List<Ingestion>? meals;
  final String header;
  Day({required this.meals, required this.header});

  @override
  State<Day> createState() => _DayState();
}

class _DayState extends State<Day> {
  BehaviorSubject<bool> show = BehaviorSubject.seeded(false);

  @override
  Widget build(BuildContext context) {
    DataMeal data = context.watch<DataMeal>();
    if (data.getFoodTypes.isEmpty) return Container();
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
              child: EatingFor24Hours(
                weight: ((widget.meals?.isNotEmpty ?? false) && data.getFoodTypes.isNotEmpty)
                    ? widget.meals
                            ?.map((e) =>
                                e.weight *
                                data.getFoodTypes.firstWhere((element) => element.id == e.foodId).calorie /
                                100)
                            .fold(0, (p, s) => s = s + (p ?? 0)) ??
                        0
                    : 0,
                title: widget.header,
              ),
              onPressed: () {
                show.add(!show.value);
              },
            ),
            StreamBuilder(
              stream: show.stream,
              builder: (context, snapshot) {
                if (show.value)
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: <Meal>[
                        if (widget.meals?.isNotEmpty ?? false)
                          ...widget.meals
                                  ?.map(
                                    (value) => Meal(
                                      ingestion: value,
                                    ),
                                  )
                                  .toList() ??
                              [],
                      ],
                    ),
                  );
                return SizedBox(height: 0);
              },
            ),
          ],
        ),
      ),
    );
  }
}
