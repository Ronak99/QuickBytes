enum Relevancy {
  all,
  major,
}

class NewsArticle {
  String title;
  String content;
  String image;
  DateTime publishedOn;
  List<String> categoryList;
  Relevancy relevancy;
  String sourceUrl;
  NewsArticle({
    required this.title,
    required this.content,
    required this.image,
    required this.publishedOn,
    required this.categoryList,
    required this.relevancy,
    required this.sourceUrl,
  });
}
