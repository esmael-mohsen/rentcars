import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentapp/data/models/car_model.dart';

class FirebaseDataSource {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseDataSource({required this.firestore});
  Future<List<CarModel>> getCars() async {
    final snapshot = await firestore.collection('cars').get();
    return snapshot.docs.map((doc) => CarModel.fromMap(doc.data())).toList();
  }
}
