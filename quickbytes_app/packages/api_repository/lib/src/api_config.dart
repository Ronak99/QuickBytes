class ApiConfig {
  static const String baseUrl = "http://192.168.0.101:8081";
  static const String version = "/v1";
}

class ApiUrl {
  static Uri apiUrl(String url) {
    // var urlObject =
    //     Uri.parse(ApiConfig.version + url).replace(host: ApiConfig.baseUrl);
    return Uri.parse("http://192.168.0.101:8081/v1/$url");
    // return Uri.parse("http://192.168.0.101:8081/v1/$url");
  }
}

class APIRoutes {
  static ArticleRoutes article = ArticleRoutes();
  static Uri get uploadImage => ApiUrl.apiUrl("/utils/image/upload");

  static Uri createConversation(String id) =>
      ApiUrl.apiUrl("/conversations/$id");
  static Uri getConversation(String id) => ApiUrl.apiUrl("/conversations/$id");
  static Uri generateImages(String conversationId) =>
      ApiUrl.apiUrl("/ad_creatives/generate-images/$conversationId");
  static Uri queryInfinite() => ApiUrl.apiUrl("/conversations");
  static Uri queryVariants() => ApiUrl.apiUrl("/conversations/variants");
  static Uri getMessages(String conversationId) =>
      ApiUrl.apiUrl("/conversations/$conversationId/messages");
}

class ArticleRoutes {
  final _baseRoute = '/articles';
  Uri get index => Uri.parse("http://192.168.0.103:8081/v1/articles");
  // Uri get index => ApiUrl.apiUrl("http://localhost:8081/v1/articles");
}
