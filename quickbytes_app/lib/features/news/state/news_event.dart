part of 'news_bloc.dart';

sealed class NewsEvent {
  const NewsEvent();
}

final class AddToTopRequested extends NewsEvent {
  const AddToTopRequested(this.article);
  final Article article;
}

class CardSwitched extends NewsEvent {
  final int index;

  CardSwitched({required this.index});
}

class ArticleSelectedAtIndex extends NewsEvent {
  final int index;

  ArticleSelectedAtIndex(this.index);
}

class AllArticlesRequested extends NewsEvent {
  AllArticlesRequested();
}
