part of 'news_bloc.dart';

@immutable
final class NewsState extends Equatable {
  final List<Article> allArticles;
  final List<Article> userArticles;
  final int index;
  final Article? articleToSelect;
  final bool isFetchingMoreData;
  final bool isFetchingInitialData;

  const NewsState({
    this.allArticles = const [],
    this.userArticles = const [],
    this.index = 0,
    this.articleToSelect,
    this.isFetchingMoreData = false,
    this.isFetchingInitialData = true,
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
        isFetchingMoreData,
        isFetchingInitialData,
      ];

  NewsState copyWith({
    List<Article>? allArticles,
    List<Article>? userArticles,
    int index = 0,
    Article? articleToSelect,
    bool? isFetchingMoreData,
    bool? isFetchingInitialData,
  }) {
    return NewsState(
      allArticles: allArticles ?? this.allArticles,
      userArticles: userArticles ?? this.userArticles,
      isFetchingMoreData: isFetchingMoreData ?? this.isFetchingMoreData,
      index: index,
      articleToSelect: articleToSelect ?? this.articleToSelect,
      isFetchingInitialData:
          isFetchingInitialData ?? this.isFetchingInitialData,
    );
  }
}
