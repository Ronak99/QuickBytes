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

class ArticleSelected extends NewsEvent {
  final Article article;

  ArticleSelected(this.article);
}
