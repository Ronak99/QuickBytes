import 'package:api_repository/src/api_config.dart';
import 'package:api_repository/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class ArticleEndpoint {
  Future<List<dynamic>> queryArticles(
      {required List<String> categoryIdList}) async {
    try {
      Uri uri = APIRoutes.article.articles(
        queryParameters: {
          "category_ids": categoryIdList,
        },
      );

      Response<Map<String, dynamic>> response =
          await Dio().getUri<Map<String, dynamic>>(uri);

      if (response.data == null) {
        return [];
      }

      return response.data!["data"];
    } on DioException catch (e) {
      throw QueryArticleApiException.fromDioException(e);
    }
  }
}
