import 'package:api_repository/src/api_config.dart';
import 'package:api_repository/src/exceptions/exceptions.dart';
import 'package:dio/dio.dart';

class NotificationEndpoint {
  Future<void> registerToken({required String? token}) async {
    try {
      Uri uri = APIRoutes.notifications();
      await Dio().postUri(uri, data: {"token": token});
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}
