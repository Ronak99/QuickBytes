import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_repository/firebase_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/app/app.dart';
import 'package:quickbytes_app/service/notification_service.dart';
import 'package:flutter/widgets.dart';

_setupBloc() {
  Bloc.observer = const AppBlocObserver();
}

_setupLocalEmulator() {
  FirebaseRepository.instance.setup.useEmulatorInDebug();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  NotificationService().initialize();
  _setupBloc();
  _setupLocalEmulator();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  runApp(
    App(authenticationRepository: authenticationRepository),
  );
}
