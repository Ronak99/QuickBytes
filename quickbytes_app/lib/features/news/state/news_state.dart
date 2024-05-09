part of 'news_bloc.dart';

@immutable
final class NewsState extends Equatable {
  final List<Article> allArticles;
  final List<Article> userArticles;
  final int index;
  final Article? articleToSelect;
  final bool isFetchingMoreData;

  const NewsState({
    this.allArticles = const [],
    this.userArticles = const [],
    this.index = 0,
    this.articleToSelect,
    this.isFetchingMoreData = false,
  });

  Article? get selectedArticle =>
      articleToSelect ?? (userArticles.isNotEmpty ? userArticles[index] : null);

  @override
  List<Object?> get props => [
        allArticles,
        userArticles,
        selectedArticle,
        index,
        articleToSelect,
        isFetchingMoreData
      ];

  NewsState copyWith({
    List<Article>? allArticles,
    List<Article>? userArticles,
    int index = 0,
    Article? articleToSelect,
    bool? isFetchingMoreData,
  }) {
    return NewsState(
      allArticles: allArticles ?? this.allArticles,
      userArticles: userArticles ?? this.userArticles,
      isFetchingMoreData: isFetchingMoreData ?? this.isFetchingMoreData,
      index: index,
      articleToSelect: articleToSelect,
    );
  }
}
