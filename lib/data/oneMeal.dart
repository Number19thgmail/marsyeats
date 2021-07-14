import 'package:flutter/cupertino.dart';

class OneMeal {
  String docId;
  String time;
  String food;
  String description;
  String name;

  OneMeal({
    @required this.time,
    @required this.food,
    @required this.description,
    @required this.name,
  });

  OneMeal.fromJson({
    Map<String, dynamic> data,
    this.docId,
  }) {
    time = data['time'];
    food = data['food'];
    description = data['description'];
    name = data['name'];
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'food': food,
      'description': description,
      'name': name,
    };
  }
}
