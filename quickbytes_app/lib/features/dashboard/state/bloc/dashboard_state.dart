part of 'dashboard_bloc.dart';

class DashboardState {
  // Tracks and updates the news category shown within the news category update UI
  List<NewsCategory> selectedCategoryList = [];

  DashboardState({required this.selectedCategoryList});

  initialize() {}

  DashboardState copyWith({
    List<NewsCategory>? selectedCategoryList,
  }) {
    return DashboardState(
      selectedCategoryList: selectedCategoryList ?? this.selectedCategoryList,
    );
  }
}
