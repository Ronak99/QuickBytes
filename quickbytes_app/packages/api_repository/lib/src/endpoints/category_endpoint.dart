import 'package:api_repository/src/api_config.dart';
import 'package:api_repository/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class CategoryEndpoint {
  Future<List<dynamic>> queryCategories() async {
    try {
      Uri uri = APIRoutes.categories();

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
