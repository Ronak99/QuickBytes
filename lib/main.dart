import 'dart:io';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/features/base/app.dart';
import 'package:quickbytes_app/features/notifications/domain/repositories/notification_service.dart';

void main() async {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  final newsRepository = NewsRepository();
  await newsRepository.init();

  await authenticationRepository.user.first;

  NotificationService.instance.initialize();
  Bloc.observer = const AppBlocObserver();

  NotificationService.instance.initialize();

  FlutterNativeSplash.remove();

  runApp(
    App(
      authenticationRepository: authenticationRepository,
      newsRepository: newsRepository,
    ),
  );
}
