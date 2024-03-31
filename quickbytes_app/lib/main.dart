import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_repository/firebase_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:quickbytes_app/features/base/app.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  NotificationService.instance.initialize();
  Bloc.observer = const AppBlocObserver();
  FirebaseRepository.instance.setup.useEmulatorInDebug();

  runApp(
    App(authenticationRepository: authenticationRepository),
  );
}
