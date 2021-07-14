import 'package:flutter/material.dart';
import 'package:marsyeats/data/type_food.dart';
import 'package:intl/intl.dart';
import 'package:marsyeats/servises/operation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Meal extends StatelessWidget {
  final String id;
  final String descrition;
  final DateTime time;
  final Foods type;
  final String name;
  Meal({
    @required this.id,
    @required this.time,
    @required this.type,
    @required this.descrition,
    @required this.name,
    Key key,
  }) : super(key: key);

   @override
  Widget build(BuildContext context) {
    String desc = descrition == '' ? type.description : descrition;
    String rName = name == 'Dmitry' ? 'Дима дал' : 'Лера дала';
    String given = type.type == 'dry' ? '$rName $desc грамм' : '$rName $desc';

    void deleteCurrentMeal()  {
    Alert(
      context: context,
      type: AlertType.warning,
      title: 'Удалить выбранный элемент?',
      buttons: [
        DialogButton(
          child: Text('Нет'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        DialogButton(
          child: Text('Да'),
          onPressed: () {
            DatabaseService().deleteMeal(id);
            Navigator.pop(context);
          },
        ),
      ],
    ).show();
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
              '$given',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
            Image(
              height: 50.0,
              image: AssetImage(
                type.image,
              ),
              fit: BoxFit.fitHeight,
            ),
            Text(
              'В ${DateFormat('HH:mm').format(time)}',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
