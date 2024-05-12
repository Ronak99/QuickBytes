part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class SwitchToNewsPageRequested extends HomeEvent {
  SwitchToNewsPageRequested();
}

class CardSwitchRequested extends HomeEvent {
  final int index;

  CardSwitchRequested(this.index);
}
