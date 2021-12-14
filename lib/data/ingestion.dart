import 'package:cloud_firestore/cloud_firestore.dart';

class Ingestion {
  String? docId;
  final Timestamp time;
  final int foodId;
  final int weight;
  final String name;

  Ingestion({this.docId,
    required this.time,
    required this.foodId,
    required this.weight,
    required this.name,
  });

  factory Ingestion.fromJson({
    required Map<String, dynamic> data,
    required String docId,
  }) {
    Timestamp time = data['time'] as Timestamp;
    int foodId = (data['foodId'] as num).toInt();
    int weight = (data['weight'] as num).toInt();
    String name = data['name'];
    return Ingestion(time: time, foodId: foodId, weight: weight, name: name, docId: docId);
  }

  Map<String, dynamic> toMap() {
    return {
      'time': time,
      'foodId': foodId,
      'weight': weight,
      'name': name,
    };
  }
}
