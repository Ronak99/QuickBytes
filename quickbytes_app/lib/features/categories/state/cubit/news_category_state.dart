part of 'news_category_cubit.dart';

sealed class NewsCategoryState extends Equatable {
  const NewsCategoryState();
}

class NewsCategoryStateInitial extends NewsCategoryState {
  @override
  List<Object?> get props => [];
}

class NewsCategoryStateLoading extends NewsCategoryState {
  @override
  List<Object?> get props => [];
}

// ignore: must_be_immutable
final class NewsCategoryStateLoaded extends NewsCategoryState {
  final List<NewsCategory> allCategories;
  final List<NewsCategory> userCategories;

  final int index;

  NewsCategoryStateLoaded({
    required this.allCategories,
    required this.userCategories,
    this.index = 0,
  }) {
    if (allCategories.isEmpty) {
      return;
    }
  }

  Map<String, List<NewsCategory>> getCategoriesByLabel(
      List<NewsCategory> categoryList) {
    Map<String, List<NewsCategory>> categoriesByLabel = {};
    for (var category in categoryList) {
      if (categoriesByLabel.containsKey(category.label)) {
        categoriesByLabel[category.label]!.add(category);
      } else {
        categoriesByLabel.putIfAbsent(category.label, () => [category]);
      }
    }
    return categoriesByLabel;
  }

  @override
  List<Object?> get props => [allCategories, userCategories, index];

  NewsCategoryStateLoaded copyWith({
    List<NewsCategory>? allCategories,
    List<NewsCategory>? userCategories,
    int index = 0,
  }) {
    return NewsCategoryStateLoaded(
      allCategories: allCategories ?? this.allCategories,
      userCategories: userCategories ?? this.userCategories,
      index: index,
    );
  }
}
