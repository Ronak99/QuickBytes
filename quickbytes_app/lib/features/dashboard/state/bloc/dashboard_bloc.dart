import 'package:news_repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(selectedCategoryList: [])) {
    on<IntializeCategoryListRequested>(onInitializeCategoryList);
    on<NewsCategorySelected>(onNewsCategorySelect);
  }

  void onInitializeCategoryList(
    IntializeCategoryListRequested event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedCategoryList: event.newsCategoryList));
  }

  void onNewsCategorySelect(
    NewsCategorySelected event,
    Emitter<DashboardState> emit,
  ) {
    NewsCategory selectedNewsCategory = event.newsCategory;

    List<NewsCategory> selectedCategoryList = state.selectedCategoryList;

    int indexOfCategoryToReplace = selectedCategoryList.indexWhere(
      (category) => category.label == selectedNewsCategory.label,
    );

    selectedCategoryList[indexOfCategoryToReplace] = selectedNewsCategory;

    emit(state.copyWith(selectedCategoryList: selectedCategoryList));
  }
}
