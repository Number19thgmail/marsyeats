import 'package:flutter/widgets.dart';
import 'package:marsyeats/data/oneMeal.dart';
import 'package:marsyeats/servises/operation.dart';

class DataMeal with ChangeNotifier {
  List<OneMeal> _meals = [];
  DataMeal() {
    var stream = DatabaseService().getMeal();
    stream.listen((List<OneMeal> data) {
      _meals = [];
      data.forEach(
        (element) {
          changeMeals(element);
        },
      );
    });
  }

  List<OneMeal> get getMeals => _meals;

  void changeMeals(OneMeal meal) {
    _meals = [..._meals, meal];

    notifyListeners();
  }
}
