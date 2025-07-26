import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = "Request to API server was cancelled.";
        break;
      case DioExceptionType.connectionTimeout:
        message = "Connection timeout with API server.";
        break;
      case DioExceptionType.receiveTimeout:
        message = "Receive timeout in connection with API server.";
        break;
      case DioExceptionType.sendTimeout:
        message = "Send timeout in connection with API server.";
        break;
      case DioExceptionType.badCertificate:
        message = "Bad certificate received.";
        break;
      case DioExceptionType.badResponse:
        message = _handleBadResponse(dioError.response!);
        break;
      case DioExceptionType.connectionError:
        message = "Connection to API server failed.";
        break;
      case DioExceptionType.unknown:
        message = "Unexpected error occurred.";
        break;
    }
  }

  String _handleBadResponse(Response response) {
    switch (response.statusCode) {
      case 400:
        return "Bad request.";
      case 401:
        return "Unauthorized. Please log in again.";
      case 403:
        return "Access denied.";
      case 404:
        return "The requested resource was not found.";
      case 500:
        return "Internal server error.";
      case 502:
        return "Bad gateway.";
      default:
        return "Received invalid status code: ${response.statusCode}";
    }
  }

  @override
  String toString() => message;
}
