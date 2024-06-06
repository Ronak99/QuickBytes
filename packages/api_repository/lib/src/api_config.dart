class ApiConfig {
  static const String baseUrl = "http://192.168.1.3:8081";
  // static const String baseUrl =
  //     "http://quickbytes-backend-production.up.railway.app";
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

class APIRoutes {
  static Uri articles({Map<String, dynamic>? queryParameters}) => ApiUrl.parse(
        endpoint: "/articles",
        queryParameters: queryParameters,
      );

  static Uri categories({Map<String, dynamic>? queryParameters}) =>
      ApiUrl.parse(
        endpoint: "/categories",
        queryParameters: queryParameters,
      );

  static Uri notifications({Map<String, dynamic>? queryParameters}) =>
      ApiUrl.parse(
        endpoint: "/notifications",
        queryParameters: queryParameters,
      );
}

class Routes {}

class CategoryRoutes {}
