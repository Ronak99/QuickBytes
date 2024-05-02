part of 'dashboard_bloc.dart';

sealed class DashboardEvent {}

class NewsCategorySelected extends DashboardEvent {
  final NewsCategory newsCategory;

  NewsCategorySelected({required this.newsCategory});
}

class IntializeCategoryListRequested extends DashboardEvent {
  final List<NewsCategory> newsCategoryList;

  IntializeCategoryListRequested({required this.newsCategoryList});
}
