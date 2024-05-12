part of 'home_bloc.dart';

class HomeState extends Equatable {
  final int index;
  final PageController pageController = PageController(initialPage: 1);

  HomeState({
    this.index = 0,
  });

  void goToNewsSubpage() {
    if (pageController.hasClients) {
      pageController.animateToPage(
        1,
        duration: const Duration(milliseconds: 150),
        curve: Curves.easeInOut,
      );
    } else {
      Logger.instance.e('Page controller has no clients.');
    }
  }

  @override
  List<Object?> get props => [];

  HomeState copyWith({int? index}) {
    return HomeState(
      index: index ?? this.index,
    );
  }
}
