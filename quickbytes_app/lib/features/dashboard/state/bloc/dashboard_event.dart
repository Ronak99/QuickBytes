part of 'dashboard_bloc.dart';

sealed class DashboardEvent {}

class NewsCategorySelected extends DashboardEvent {
  final NewsCategory newsCategory;

  NewsCategorySelected({required this.newsCategory});
}

class IntializCategoryListRequested extends DashboardEvent {
  final List<NewsCategory> newsCategoryList;

  IntializCategoryListRequested({required this.newsCategoryList});
}
