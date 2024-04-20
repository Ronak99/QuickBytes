import 'package:api_repository/api_repository.dart';
import 'package:cache_repository/cache_repository.dart';
import 'package:news_repository/src/exceptions/news_exceptions.dart';
import 'package:news_repository/src/models/models.dart';

class NewsRepository {
  late ApiRepository _apiRepository;
  late CacheRepository _cacheRepository;

  Future<void> init() async {
    _cacheRepository = CacheRepository.instance;
    await _cacheRepository.init();

    _apiRepository = ApiRepository.instance;
  }

  Future<List<Article>> queryAllArticles({
    required List<String> categoryIdList,
  }) async {
    try {
      List<dynamic> articleList =
          await _cacheRepository.articles.queryArticles();

      if (articleList.isEmpty) {
        articleList = await _apiRepository.articles.queryArticles(
          categoryIdList: categoryIdList,
        );
        _cacheRepository.articles.saveArticles(
          articleList.map((e) => e as Map<String, dynamic>).toList(),
        );
      }

      return articleList.map((e) => Article.fromJson(e)).toList();
    } catch (e) {
      if (e is QueryArticleApiException) {
        throw QueryArticleNewsException(message: e.message);
      } else if (e is QueryArticleCacheException) {
        throw QueryArticleNewsException(message: e.message);
      }
      return [];
    }
  }
}
