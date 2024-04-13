class ApiConfig {
  static const String baseUrl = "http://192.168.0.101:8081";
  static const String version = "/v1";
}

class ApiUrl {
  static Uri apiUrl(String url) {
    var urlObject = Uri.parse(ApiConfig.baseUrl + ApiConfig.version + url);
    return urlObject;
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
  Uri get articles => ApiUrl.apiUrl("/articles");
}
