part of 'news_bloc.dart';

List<Article> articleList = [
  Article(
    id: '123',
    title:
        "Princess of Wales: First official picture of Kate since surgery released",
    content:
        '''Prince William took a photo at Windsor showing Princess Catherine with her three children, thanking the public for support. She won't resume duties before Easter. Catherine expressed gratitude on social media for well wishes during her 13-night hospital stay in London after surgery. The photo captures her surrounded by Princess Charlotte, Prince Louis, and Prince George.''',
    image: "https://www.picsum.photos/500",
    categoryList: [],
    publishedOn: DateTime.now(),
    sourceUrl: "https://www.google.com",
  ),
  Article(
    id: "890",
    title: "Portugal votes in election where far right could play kingmaker",
    content:
        '''Opinion polls indicate neither Socialists nor centre-right will secure a majority, potentially giving the far-right Chega party influence. Mainstream parties aim to exclude Chega. The upcoming election follows Prime Minister Antonio Costa's resignation due to corruption allegations, though he was not implicated. His chief of staff was arrested for suspected irregularities in state contracts. André Ventura of Chega emphasizes corruption and immigration in his campaign.''',
    image: "https://www.picsum.photos/700",
    categoryList: [],
    publishedOn: DateTime.now(),
    sourceUrl: "https://www.google.com",
  ),
];

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
