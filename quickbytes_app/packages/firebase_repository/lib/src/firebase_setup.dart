import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseSetup {
  static FirebaseSetup? _instance;

  static FirebaseSetup get instance {
    _instance ??= FirebaseSetup();
    return _instance!;
  }

  useEmulatorInDebug() {
    if (kDebugMode) {
      try {
        FirebaseFirestore.instance.settings = const Settings(
          host: '192.168.0.101:8080',
          sslEnabled: false,
          persistenceEnabled: false,
        );
      } catch (e) {
        print(e);
      }
    }
  }
}
