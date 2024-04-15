import 'package:api_repository/src/api_config.dart';
import 'package:dio/dio.dart';

class ArticleEndpoint {
  // Future<List<dynamic>> queryArticles() async {
  //   try {
  //     Response<Map<String, dynamic>> response =
  //         await Dio().getUri<Map<String, dynamic>>(APIRoutes.article.articles);

  //     if (response.data == null) {
  //       return [];
  //     }

  //     return response.data!["data"];
  //   } on DioException catch (e) {
  //     print(e.message);
  //     return [];
  //   }
  // }
}
