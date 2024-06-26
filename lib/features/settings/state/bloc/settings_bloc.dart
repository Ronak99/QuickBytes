import 'package:equatable/equatable.dart';
import 'package:news_repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState(selectedCategoryList: [])) {
    on<IntializeCategoryListRequested>(onInitializeCategoryList);
    on<NewsCategorySelected>(onNewsCategorySelect);
  }

  void onNewsCategorySelect(
    NewsCategorySelected event,
    Emitter<SettingsState> emit,
  ) {
    NewsCategory selectedNewsCategory = event.newsCategory;

    List<NewsCategory> selectedCategoryList =
        List.from(state.selectedCategoryList);

    int indexOfCategoryToReplace = selectedCategoryList.indexWhere(
      (category) => category.label == selectedNewsCategory.label,
    );

    selectedCategoryList[indexOfCategoryToReplace] = selectedNewsCategory;

    emit(state.copyWith(selectedCategoryList: selectedCategoryList));
  }

  void onInitializeCategoryList(
    IntializeCategoryListRequested event,
    Emitter<SettingsState> emit,
  ) {
    emit(state.copyWith(selectedCategoryList: event.newsCategoryList));
  }
}
