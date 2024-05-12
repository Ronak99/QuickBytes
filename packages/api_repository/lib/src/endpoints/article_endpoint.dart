import 'package:api_repository/src/api_config.dart';
import 'package:api_repository/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class ArticleEndpoint {
  Future<List<dynamic>> queryArticles({
    required List<String>? categoryIdList,
    String? cursorId,
    int? limit,
  }) async {
    try {
      Map<String, dynamic> queryParameters = {
        "limit": limit?.toString(),
        "cursor_id": cursorId,
      };

      if (categoryIdList != null && categoryIdList.isNotEmpty) {
        queryParameters["category_ids[]"] = categoryIdList;
      }

      Uri uri = APIRoutes.articles(queryParameters: queryParameters);

      Response<Map<String, dynamic>> response =
          await Dio().getUri<Map<String, dynamic>>(uri);

      if (response.data == null) {
        return [];
      }

      return response.data!["data"];
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
