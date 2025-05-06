import 'package:cloud_firestore/cloud_firestore.dart';

// TODO: Consider if this generic FirebaseApi should be a singleton or provided via DI.
// TODO: Add more robust error handling for Firestore operations.
class FirebaseApi {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref; // Made non-nullable and initialized in constructor

  FirebaseApi(this.path) {
    ref = _db.collection(path);
  }

  Future<DocumentReference> addDocument(Map<String, dynamic> data) { // Explicit type for data
    return ref.add(data);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get();
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id) {
    return ref.doc(id).delete();
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots();
  }

  Future<void> updateDocument(Map<String, dynamic> data, String id) { // Explicit type for data
    return ref.doc(id).update(data);
  }
} 