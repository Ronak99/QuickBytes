part of 'news_bloc.dart';

List<Article> articleList = [];

sealed class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

final class NewsLoaded extends NewsState {
  final List<Article> articles;
  final int index;

  const NewsLoaded({
    required this.articles,
    this.index = 0,
  });

  Article? get selectedArticle => articles.isNotEmpty ? articles[index] : null;

  @override
  List<Object?> get props => [articles, selectedArticle, index];

  NewsLoaded copyWith({List<Article>? articles, int index = 0}) {
    return NewsLoaded(
      articles: articles ?? this.articles,
      index: index,
    );
  }
}
