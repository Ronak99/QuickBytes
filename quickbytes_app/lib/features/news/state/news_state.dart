part of 'news_bloc.dart';

final class NewsState extends Equatable {
  final List<Article> allArticles;
  final List<Article> userArticles;
  final int index;
  final Article? articleToSelect;

  const NewsState({
    this.allArticles = const [],
    this.userArticles = const [],
    this.index = 0,
    this.articleToSelect,
  });

  Article? get selectedArticle =>
      articleToSelect ?? (userArticles.isNotEmpty ? userArticles[index] : null);

  @override
  List<Object?> get props =>
      [allArticles, selectedArticle, index, articleToSelect];

  NewsState copyWith({
    List<Article>? allArticles,
    List<Article>? userArticles,
    int index = 0,
    Article? articleToSelect,
  }) {
    return NewsState(
      allArticles: allArticles ?? this.allArticles,
      userArticles: userArticles ?? this.userArticles,
      index: index,
      articleToSelect: articleToSelect,
    );
  }
}
