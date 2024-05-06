part of 'news_bloc.dart';

sealed class NewsEvent {
  const NewsEvent();
}

/// Adds article to the top of the article list
final class AddToTopRequested extends NewsEvent {
  const AddToTopRequested(this.article);
  final Article article;
}

class CardSwitchedRequested extends NewsEvent {
  final int index;

  CardSwitchedRequested({required this.index});
}

/// Selects article at given index, which updates the background image
class ArticleSelectedAtIndex extends NewsEvent {
  final int index;

  ArticleSelectedAtIndex(this.index);
}

class ArticleSelected extends NewsEvent {
  final Article selectedArticle;

  ArticleSelected(this.selectedArticle);
}

class UserArticlesRequested extends NewsEvent {
  final List<NewsCategory> userCategories;

  UserArticlesRequested({required this.userCategories});

  List<String> get userCategoriesId =>
      userCategories.where((e) => !e.isNone).map((e) => e.id).toList();
}

class AllArticlesRequested extends NewsEvent {
  AllArticlesRequested();
}

class NewsEventUserCategoriesChanged extends NewsEvent {
  final List<NewsCategory> categoriesAdded;
  final List<NewsCategory> categoriesRemoved;

  List<String> get categoriesAddedIds =>
      categoriesAdded.map((e) => e.id).toList();

  NewsEventUserCategoriesChanged({
    required this.categoriesRemoved,
    required this.categoriesAdded,
  });
}
