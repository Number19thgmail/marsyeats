import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:marsyeats/data/dataMeal.dart';
import 'package:marsyeats/data/ingestion.dart';
import 'package:marsyeats/servises/ingestions/ingestions.dart';
import 'package:provider/src/provider.dart';

class Meal extends StatelessWidget {
  final Ingestion ingestion;
  Meal({
    required this.ingestion,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rName = ingestion.name == 'Dmitry' ? 'Дима дал' : 'Лера дала';
    String given = '${ingestion.weight} грамм';
    DataMeal data = context.watch<DataMeal>();

    void deleteCurrentMeal() {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Что сделать?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Удалить'),
              onPressed: () {
                IngestionService().deleteIngestion(ingestion.docId);
                Navigator.pop(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Изменить время'),
              onPressed: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2019),
                  lastDate: DateTime(2055),
                );
                if (date != null) {
                  TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    initialEntryMode: TimePickerEntryMode.dial,
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );
                  if (time != null) {
                    DateTime selected = DateTime(date.year, date.month, date.day, time.hour, time.minute);
                    IngestionService().changeIngestion(
                      meal: Ingestion(
                        time: Timestamp.fromDate(selected),
                        foodId: ingestion.foodId,
                        weight: ingestion.weight,
                        name: ingestion.name,
                        docId: ingestion.docId,
                      ),
                    );
                  }
                }
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
        ),
      );
    }

    return GestureDetector(
      onLongPress: deleteCurrentMeal,
      child: Container(
        width: (MediaQuery.of(context).size.width - 48) / 2,
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(20),
            right: Radius.circular(20),
          ),
          border: Border.all(
            color: Colors.blue,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Text(
              '$rName $given',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 2),
            Image(
              height: 45.0,
              image: AssetImage(
                'assets/images/${data.getFoodTypes.firstWhere((element) => element.id == ingestion.foodId).image}',
              ),
              fit: BoxFit.fitHeight,
            ),
            const SizedBox(height: 2),
            Text(
              'В ${DateFormat('HH:mm').format(ingestion.time.toDate())}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
