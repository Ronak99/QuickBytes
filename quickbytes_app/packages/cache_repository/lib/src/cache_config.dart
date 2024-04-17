class ApiConfig {
  static const String baseUrl = "http://192.168.0.101:8081";
  static const String version = "/v1";
}

class ApiUrl {
  static Uri parse({
    required String endpoint,
    Map<String, dynamic>? queryParameters,
  }) {
    var urlObject = Uri.parse(ApiConfig.baseUrl + ApiConfig.version + endpoint);
    if (queryParameters != null) {
      urlObject = urlObject.replace(queryParameters: queryParameters);
    }

    return urlObject;
  }
}

class CacheRoutes {
  static ArticleRoutes article = ArticleRoutes();
}

class ArticleRoutes {
  String get articles => 'articles';
}
