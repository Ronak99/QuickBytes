import 'package:cache_repository/src/cache_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticleEndpoint {
  Box<Map>? _newsBox;

  ArticleEndpoint();

  init() async {
    _newsBox = await Hive.openBox<Map>(CacheRoutes.article.articles);
  }

  Future<List<Map<String, dynamic>>> queryArticles() async {
    if (_newsBox == null) {
      // ensuring that this function is smart enough to handle the null case for news box
      // sometimes, when queryArticles is called on initState, the box isn't even properly initialized
      // by the time, the flow reaches, query articles.
      await init();
      return queryArticles();
    }

    List<Map> valueList = _newsBox!.values.toList();

    List<Map<String, dynamic>> articleMapList =
        valueList.map((e) => Map<String, dynamic>.from(e)).toList();

    return articleMapList;
  }

  saveArticles(List<Map<String, dynamic>> articleList) async {
    if (_newsBox == null) return [];
    _newsBox!.addAll(articleList);
  }
}
