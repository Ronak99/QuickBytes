import 'package:api_repository/src/api_config.dart';
import 'package:dio/dio.dart';

class ArticleEndpoint {
  Future<List<dynamic>> queryArticles() async {
    try {
      Response<Map<String, dynamic>> response =
          await Dio().getUri<Map<String, dynamic>>(APIRoutes.article.index);

      if (response.data == null) {
        throw Exception('Data was null');
      }

      return response.data!["data"];
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Error Occurred');
    }
  }
}
