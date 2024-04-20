import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_repository/news_repository.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/shared/utils/utils.dart';
import 'package:quickbytes_app/features/base/presentation/view/app.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (error is QueryArticleNewsException) {
      Utils.showSnackbar(message: error.message);
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // if (change.currentState.runtimeType == NewsState) return;
    // Logger.instance.t(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (transition.currentState.runtimeType == NewsState) return;
    // Logger.instance.t(transition);
  }
}

class ErrorHandler {}
