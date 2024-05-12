import 'package:dio/dio.dart';

class ApiException implements Exception {
  const ApiException({
    this.message = 'An unknown exception occurred.',
  });

  factory ApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const ApiException(message: "Connection Timeout!");
      case DioExceptionType.sendTimeout:
        return const ApiException(message: "Sent Timeout!");
      case DioExceptionType.receiveTimeout:
        return const ApiException(message: "Received Timeout!");
      case DioExceptionType.badCertificate:
        return const ApiException(message: "Bad Certificate!");
      case DioExceptionType.badResponse:
        String message = 'Bad Response!';
        if (dioException.response != null) {
          Map map = dioException.response!.data as Map;
          if (map.containsKey('message')) {
            message = dioException.response!.data['message'];
          }
        }
        return ApiException(message: message);
      case DioExceptionType.cancel:
        return const ApiException(message: "Request Cancelled!");
      case DioExceptionType.connectionError:
        return const ApiException(message: "Connection Error!");
      case DioExceptionType.unknown:
      default:
        return const ApiException(
          message: "An unknown error occurred!",
        );
    }
  }

  final String message;
}
