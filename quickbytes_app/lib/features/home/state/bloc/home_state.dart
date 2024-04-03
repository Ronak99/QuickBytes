part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int index;
  final CardSwiperController cardSwiperController = CardSwiperController();

  HomeState({
    this.index = 0,
  });

  @override
  List<Object?> get props => [];

  HomeState copyWith({int? index}) {
    if (index != null) {
      cardSwiperController.moveTo(index);
    }

    return HomeState(
      index: index ?? this.index,
    );
  }
}
