import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marsyeats/data/oneMeal.dart';

class DatabaseService {
  final CollectionReference _mealCollection =
      FirebaseFirestore.instance.collection('meals');

  Future addMeal({OneMeal meal}) {
    return _mealCollection
        .add(
          meal.toMap(),
        )
        .then((value) => meal.docId = value.id);
  }

  Stream<List<OneMeal>> getMeal() {
    Query query = _mealCollection.where(
      'time',
      isGreaterThan: DateTime.now().add(Duration(days: -2)).toString(),
    );
    return query
        .snapshots(includeMetadataChanges: true)
        .map((QuerySnapshot data) => data.docs
            .map(
              (DocumentSnapshot doc) =>
                  OneMeal.fromJson(data: doc.data(), docId: doc.id),
            )
            .toList());
  }

  void deleteMeal(String id){
    _mealCollection.doc(id).delete();
  }
}
