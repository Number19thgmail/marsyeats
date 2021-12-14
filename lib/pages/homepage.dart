import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marsyeats/data/ingestion.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/elements/day.dart';
import 'package:marsyeats/elements/food_type.dart';
import 'package:marsyeats/elements/input_part.dart';
import 'package:marsyeats/elements/input_weigth.dart';
import 'package:marsyeats/servises/auth.dart';
import 'package:marsyeats/servises/ingestions/ingestions.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  final String name;
  const Homepage({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DataMeal data = context.watch<DataMeal>();
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.cyan,
              child: ListView(
                children: [
                  ElevatedButton(
                    onPressed: signOutGoogle,
                    child: Text('outlog'),
                  ),
                  Day(
                    meals: data.getIngestions
                        .where(
                          (element) =>
                              DateFormat('MM.dd').format(element.time.toDate()) ==
                              DateFormat('MM.dd').format(
                                DateTime.now().add(Duration(days: -1)),
                              ),
                        )
                        .toList(),
                    header: 'Вчера',
                  ),
                  Day(
                    meals: data.getIngestions
                        .where(
                          (element) =>
                              DateFormat('MM.dd').format(element.time.toDate()) ==
                              DateFormat('MM.dd').format(
                                DateTime.now(),
                              ),
                        )
                        .toList(),
                    header: 'Сегодня',
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      height: 20,
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                  Day(
                    meals: data.getIngestions
                        .where(
                          (element) => element.time
                              .toDate()
                              .add(
                                Duration(days: 1),
                              )
                              .isAfter(
                                DateTime.now(),
                              ),
                        )
                        .toList(),
                    header: 'За последние 24 часа',
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Colors.cyan,
            child: Row(
              children: [
                Expanded(
                  child: Column(children: [
                    FoodTypeSelect(),
                    data.selectedType?.isPacked ?? false ? InputPart() : InputWeigth(),
                  ]),
                ),
                InkWell(
                  onTap: () async {
                    Ingestion current = Ingestion(
                      time: Timestamp.now(),
                      foodId: data.selectedType?.id ?? 0,
                      weight: data.weigth,
                      name: name.split(' ').first,
                    );
                    await IngestionService().addIngestion(meal: current);
                  },
                  child: Container(
                    color: Colors.transparent,
                    alignment: Alignment.centerRight,
                    child: Image(
                      image: AssetImage('assets/images/put_food.png'),
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width / 4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
