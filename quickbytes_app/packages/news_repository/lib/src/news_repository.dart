import 'package:api_repository/api_repository.dart';
import 'package:news_repository/src/models/models.dart';

class NewsRepository {
  final ApiRepository _apiRepository = ApiRepository.instance;

  Future<List<Article>> queryAllArticles() async {
    List<dynamic> articleList = await _apiRepository.articles.queryArticles();
    return articleList.map((e) => Article.fromJson(e)).toList();
  }
}
