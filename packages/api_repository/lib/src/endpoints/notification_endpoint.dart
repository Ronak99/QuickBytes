import 'package:api_repository/src/api_config.dart';
import 'package:api_repository/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class NotificationEndpoint {
  Future<void> registerToken({required String? token}) async {
    try {
      Uri uri = APIRoutes.notifications();

      Response<Map<String, dynamic>> response = await Dio()
          .postUri<Map<String, dynamic>>(uri, data: {"token": token});

      if (response.data == null) {
        return;
      }

      return response.data!["data"];
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
