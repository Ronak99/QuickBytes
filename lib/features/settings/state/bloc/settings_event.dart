part of 'settings_bloc.dart';

sealed class SettingsEvent {}

class NewsCategorySelected extends SettingsEvent {
  final NewsCategory newsCategory;

  NewsCategorySelected({required this.newsCategory});
}

class IntializeCategoryListRequested extends SettingsEvent {
  final List<NewsCategory> newsCategoryList;

  IntializeCategoryListRequested({required this.newsCategoryList});
}
