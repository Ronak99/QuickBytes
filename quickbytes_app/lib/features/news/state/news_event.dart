part of 'news_bloc.dart';

sealed class NewsEvent {
  const NewsEvent();
}

final class AddToTopRequested extends NewsEvent {
  const AddToTopRequested(this.article);
  final Article article;
}
