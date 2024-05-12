import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreReferences {
  static FirestoreReferences? _instance;

  static FirestoreReferences get instance {
    _instance ??= FirestoreReferences();
    return _instance!;
  }

  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  CollectionReference get newsCollection => _firestore.collection('news');
  CollectionReference get usersCollection => _firestore.collection('users');
}
