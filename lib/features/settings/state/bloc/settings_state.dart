part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  // Tracks and updates the news category shown within the news category update UI
  final List<NewsCategory> selectedCategoryList;

  const SettingsState({required this.selectedCategoryList});

  SettingsState copyWith(
      {List<NewsCategory>? selectedCategoryList, int? stateVersion}) {
    return SettingsState(
      selectedCategoryList: selectedCategoryList ?? this.selectedCategoryList,
    );
  }

  @override
  List<Object?> get props => [selectedCategoryList];
}
