import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickbytes_app/core/logs/logs.dart';
import 'package:quickbytes_app/features/news/state/news_bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Logger.instance.e(error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (change.currentState.runtimeType == NewsState) return;
    Logger.instance.t(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (transition.currentState.runtimeType == NewsState) return;
    Logger.instance.t(transition);
  }
}
