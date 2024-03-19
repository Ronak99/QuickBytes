import 'package:authentication_repository/authentication_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/app.dart';
import 'package:quickbytes_app/app/app.dart';
import 'package:quickbytes_app/app/bloc_observer.dart';
import 'package:quickbytes_app/service/notification_service.dart';
import 'package:flutter/widgets.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.notification);
}

_setupBloc() {
  Bloc.observer = const AppBlocObserver();
}

_setupMessaging() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
}

_setupLocalEmulator() {
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationService().initialize();
  _setupBloc();
  _setupMessaging();
  // _setupLocalEmulator();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(
    App(authenticationRepository: authenticationRepository),
  );
}
