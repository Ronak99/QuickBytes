import 'package:cache_repository/src/cache_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ArticleEndpoint {
  Box<Map>? _newsBox;

  ArticleEndpoint() {
    _openBox();
  }

  _openBox() async {
    _newsBox = await Hive.openBox<Map>(CacheRoutes.article.articles);
  }

  Future<List<Map<String, dynamic>>> queryArticles() async {
    if (_newsBox == null) return [];

    List<Map> valueList = _newsBox!.values.toList();

    List<Map<String, dynamic>> finalList =
        valueList.map((e) => Map<String, dynamic>.from(e)).toList();

    return finalList;
    // return _newsBox!.values
    //     .map((e) => e.map((key, value) => MapEntry(key.toString(), value)))
    //     .toList();
  }

  saveArticles(List<Map<String, dynamic>> articleList) async {
    if (_newsBox == null) return [];
    _newsBox!.addAll(articleList);
  }
}
