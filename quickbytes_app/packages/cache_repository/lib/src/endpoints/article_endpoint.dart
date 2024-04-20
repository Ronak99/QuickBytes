import 'package:cache_repository/cache_repository.dart';
import 'package:cache_repository/src/cache_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticleEndpoint {
  Box<Map>? _newsBox;

  ArticleEndpoint();

  init() async {
    try {
      _newsBox = await Hive.openBox<Map>(CacheRoutes.article.articles);
    } catch (e) {
      throw const CacheInitializationError();
    }
  }

  Future<List<Map<String, dynamic>>> queryArticles() async {
    try {
      if (_newsBox == null) {
        // Ensuring that this function is smart enough to handle the null case for news box
        // sometimes, when queryArticles is called on initState, the box isn't even properly initialized
        // by the time, the flow reaches, query articles.
        await init();
        return queryArticles();
      }

      List<Map> valueList = _newsBox!.values.toList();

      List<Map<String, dynamic>> articleMapList =
          valueList.map((e) => Map<String, dynamic>.from(e)).toList();

      return articleMapList;
    } catch (e) {
      throw const QueryArticleCacheException();
    }
  }

  saveArticles(List<Map<String, dynamic>> articleList) async {
    try {
      if (_newsBox == null) return [];
      _newsBox!.addAll(articleList);
    } catch (e) {
      throw const SaveArticleCacheException();
    }
  }
}
