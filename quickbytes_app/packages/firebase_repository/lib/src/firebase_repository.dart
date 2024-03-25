import './firestore_references.dart';
import './firebase_setup.dart';

class FirebaseRepository {
  static FirebaseRepository? _instance;

  static FirebaseRepository get instance {
    _instance ??= FirebaseRepository();
    return _instance!;
  }

  FirestoreReferences get references => FirestoreReferences.instance;
  FirebaseSetup get setup => FirebaseSetup.instance;
}
