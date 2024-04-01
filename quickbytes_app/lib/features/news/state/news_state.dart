part of 'news_bloc.dart';

final class NewsState {
  List<Article> articles = [
    Article(
      id: '123',
      title:
          "Princess of Wales: First official picture of Kate since surgery released",
      content:
          '''Prince William took a photo at Windsor showing Princess Catherine with her three children, thanking the public for support. She won't resume duties before Easter. Catherine expressed gratitude on social media for well wishes during her 13-night hospital stay in London after surgery. The photo captures her surrounded by Princess Charlotte, Prince Louis, and Prince George.''',
      image: "https://www.picsum.photos/500",
      categoryList: [],
      publishedOn: DateTime.now(),
      relevancy: Relevancy.all,
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
      relevancy: Relevancy.all,
      sourceUrl: "https://www.google.com",
    ),
  ];

  void addArticleToTop(Article article) {
    articles.insert(0, article);
  }
}
