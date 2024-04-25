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

class AllArticlesRequested extends NewsEvent {
  AllArticlesRequested();
}
