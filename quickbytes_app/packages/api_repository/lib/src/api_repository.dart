import 'package:api_repository/src/endpoints/article_endpoint.dart';

/// {@template authentication_repository}
/// Repository which manages all API related calls
/// {@endtemplate}
class ApiRepository {
  static ApiRepository? _instance;

  static ApiRepository get instance {
    _instance ??= ApiRepository();
    return _instance!;
  }

  ArticleEndpoint articles = ArticleEndpoint();
}
