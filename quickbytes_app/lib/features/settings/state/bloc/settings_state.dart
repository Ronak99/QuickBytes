part of 'settings_bloc.dart';

class SettingsState {
  // Tracks and updates the news category shown within the news category update UI
  List<NewsCategory> selectedCategoryList = [];

  SettingsState({required this.selectedCategoryList});

  initialize() {}

  SettingsState copyWith({
    List<NewsCategory>? selectedCategoryList,
  }) {
    return SettingsState(
      selectedCategoryList: selectedCategoryList ?? this.selectedCategoryList,
    );
  }
}
