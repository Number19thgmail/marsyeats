import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marsyeats/data/food.dart';

class FoodService {
  final CollectionReference _foodsCollection =
      FirebaseFirestore.instance.collection('foods');

  Future addFoodType({required FoodType type}) {
    return _foodsCollection
        .add(
          type.toMap(),
        )
        .then((value) => type.docId = value.id);
  }

  Stream<List<FoodType>> getFoodTypes() {
    return _foodsCollection
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot data) => data.docs
            .map(
              (DocumentSnapshot doc) =>
                  FoodType.fromJson(data: doc.data() as Map<String, dynamic>, docId: doc.id),
            )
            .toList());
  }

  void deleteFoodType(String? id){
    _foodsCollection.doc(id).delete();
  }
}
