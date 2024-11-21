import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collectionName = "details";

  Future<void> saveDetailsToFirestore(Map<String, String> data) async {
    try {
      await _firestore.collection(_collectionName).doc().set(data);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
