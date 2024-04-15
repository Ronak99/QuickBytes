import 'package:api_repository/src/api_config.dart';
import 'package:dio/dio.dart';

class ArticleEndpoint {
  Future<List<dynamic>> queryArticles() async {
    try {
      Uri uri = APIRoutes.article.articles(
        queryParameters: {
          "category_ids": "6616ae11754e1ade06474025,6616ae12754e1ade06474029",
        },
      );

      Response<Map<String, dynamic>> response =
          await Dio().getUri<Map<String, dynamic>>(uri);

      if (response.data == null) {
        return [];
      }

      return response.data!["data"];
    } on DioException catch (e) {
      print(e.message);
      return [];
    }
  }
}
