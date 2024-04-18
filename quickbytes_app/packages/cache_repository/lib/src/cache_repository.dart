import 'package:cache_repository/src/cache_config.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'endpoints/article_endpoint.dart';

class CacheRepository {
  static CacheRepository? _instance;

  static CacheRepository get instance {
    _instance ??= CacheRepository();
    return _instance!;
  }

  ArticleEndpoint articles = ArticleEndpoint();

  Future<void> init() async {
    await Hive.initFlutter();
  }
}
