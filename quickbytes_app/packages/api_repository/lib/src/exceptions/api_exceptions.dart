import 'package:dio/dio.dart';

class QueryArticleApiException implements Exception {
  const QueryArticleApiException({
    this.message = 'An unknown exception occurred.',
  });

  factory QueryArticleApiException.fromDioException(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return const QueryArticleApiException(message: "Connection Timeout!");
      case DioExceptionType.sendTimeout:
        return const QueryArticleApiException(message: "Sent Timeout!");
      case DioExceptionType.receiveTimeout:
        return const QueryArticleApiException(message: "Received Timeout!");
      case DioExceptionType.badCertificate:
        return const QueryArticleApiException(message: "Bad Certificate!");
      case DioExceptionType.badResponse:
        String message = 'Bad Response!';
        if (dioException.response != null) {
          Map map = dioException.response!.data as Map;
          if (map.containsKey('message')) {
            message = dioException.response!.data['message'];
          }
        }
        return QueryArticleApiException(message: message);
      case DioExceptionType.cancel:
        return const QueryArticleApiException(message: "Request Cancelled!");
      case DioExceptionType.connectionError:
        return const QueryArticleApiException(message: "Connection Error!");
      case DioExceptionType.unknown:
      default:
        return const QueryArticleApiException(
          message: "An unknown error occurred!",
        );
    }
  }

  final String message;
}
