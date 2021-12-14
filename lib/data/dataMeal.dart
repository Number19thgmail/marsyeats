import 'package:flutter/widgets.dart';
import 'package:marsyeats/data/food.dart';
import 'package:marsyeats/data/ingestion.dart';
import 'package:marsyeats/servises/ingestions/foods.dart';
import 'package:marsyeats/servises/ingestions/ingestions.dart';

class DataMeal with ChangeNotifier {
  List<Ingestion> _ingestions = [];
  List<FoodType> _foodTypes = [];
  FoodType? _selectedType;
  int _foodWeigth = 0;

  DataMeal() {
    Stream<List<Ingestion>> _ingestionStream = IngestionService().getIngestions();
    _ingestionStream.listen((List<Ingestion> data) {
      _ingestions = [];
      data.forEach(
        (element) {
          changeMeals(element);
        },
      );
    });
    Stream<List<FoodType>> _foodTypeStream = FoodService().getFoodTypes();
    _foodTypeStream.listen((List<FoodType> data) {
      _foodTypes = [];
      data.forEach(
        (element) {
          changeFoodType(element);
        },
      );
    });
  }

  void changeMeals(Ingestion meal) {
    _ingestions = [..._ingestions, meal];

    notifyListeners();
  }

  void changeFoodType(FoodType foodType) {
    _foodTypes = [..._foodTypes, foodType];

    notifyListeners();
  }

  FoodType? setSelectedType(FoodType value) {
    _selectedType = value;

    notifyListeners();
    return _selectedType;
  }

  void setWeigthPart(double part) {
    _foodWeigth = (part * (_selectedType?.packWeigth ?? 0)).round();
  }


  void setWeigth(int weigth) {
    _foodWeigth = weigth;
  }

  List<Ingestion> get getIngestions => _ingestions;

  List<FoodType> get getFoodTypes => _foodTypes;

  FoodType? get selectedType => _selectedType;

  int get weigth => _foodWeigth;
}
