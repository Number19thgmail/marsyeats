import 'package:flutter/material.dart';
import 'package:marsyeats/data/dataMeal.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class EatingFor24Hours extends StatelessWidget {
  final double weight;
  final String title;
  EatingFor24Hours({required this.weight, required this.title});

  @override
  Widget build(BuildContext context) {
    DataMeal data = context.watch<DataMeal>();
    return Container(
      color: Colors.transparent,
      child: ListTile(
        tileColor: Colors.transparent,
        leading: Image(
          image: weight < 167.44
              ? AssetImage(
                  'assets/images/hungry.png',
                )
              : (weight > 207.48 ? AssetImage('assets/images/fat.png') : AssetImage('assets/images/norm.png')),
          fit: BoxFit.contain,
        ),
        title: Text(
            '$title дали еды на ${weight.ceil()} калорий, осталось ~ ${leftGram(data.getFoodTypes.firstWhere((element) => element.id == 0).calorie)} грамм'),
        subtitle: Text(
          'При избыточном - 167 калорий\nПри нормальном - 207 калорий',
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
      ),
    );
  }

  int leftGram(int cal) {
    int minWeigth = ((167 - weight) / cal * 100).round();
    int normWeigth = ((207 - weight) / cal * 100).round();
    return minWeigth > 0 ? minWeigth : normWeigth;
  }
}
