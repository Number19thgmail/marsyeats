import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:marsyeats/data/ingestion.dart';

class IngestionService {
  final CollectionReference _ingestionsCollection = FirebaseFirestore.instance.collection('ingestions');

  Future addIngestion({required Ingestion meal}) {
    return _ingestionsCollection
        .add(
          meal.toMap(),
        )
        .then((value) => meal.docId = value.id);
  }

  Stream<List<Ingestion>> getIngestions() {
    Query query = _ingestionsCollection.where(
      'time',
      isGreaterThan: DateTime.now().add(Duration(days: -2)),
    );
    return query.snapshots(includeMetadataChanges: true).map((QuerySnapshot data) => data.docs
        .map(
          (DocumentSnapshot doc) => Ingestion.fromJson(data: doc.data() as Map<String, dynamic>, docId: doc.id),
        )
        .toList());
  }

  void deleteIngestion(String? id) {
    _ingestionsCollection.doc(id).delete();
  }

  void changeIngestion({required Ingestion meal}) {
    _ingestionsCollection.doc(meal.docId).update(meal.toMap());
  }
}
