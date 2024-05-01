import 'package:news_repository/news_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardState(selectedCategoryList: [])) {
    on<IntializCategoryListRequested>(onInitializeCategoryList);
    on<NewsCategorySelected>(onNewsCategorySelect);
  }

  void onInitializeCategoryList(
    IntializCategoryListRequested event,
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
    // if (event.newsCategory != null) {
    //   NewsCategory selectedNewsCategory = event.newsCategory!;

    //   int indexOfCategoryToReplace = state.selectedCategoryList.indexWhere(
    //     (category) => category.label == selectedNewsCategory.label,
    //   );

    //   if (indexOfCategoryToReplace == -1) {
    //     state.selectedCategoryList.add(selectedNewsCategory);
    //   } else {}
    // } else {
    //   int indexOfCategoryToRemove = state.selectedCategoryList.indexWhere(
    //     (category) => category.label == categoryMap.key,
    //   );

    //   if (indexOfCategoryToRemove != -1) {
    //     // mark these categories as none
    //     NewsCategory noneNewsCategory =
    //         state.selectedCategoryList[index].copyWith(
    //       relevancy: Relevancy.none,
    //     );
    //     state.selectedCategoryList[indexOfCategoryToRemove] = noneNewsCategory;
    //   }
    // }
  }
}
