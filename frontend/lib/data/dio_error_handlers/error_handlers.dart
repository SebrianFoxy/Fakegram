import 'package:dio/dio.dart';
import 'dart:io';

class ErrorHandler {
  static String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection Timeout. Please try again later.';
      case DioExceptionType.sendTimeout:
        return 'Request Timeout. Please try again later.';
      case DioExceptionType.receiveTimeout:
        return 'Response Timeout. Please try again later.';
      case DioExceptionType.badResponse:
        return error.response?.data['error'] ?? 'Server error. Please try again later.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return 'Network error. Please check your internet connection.';
        }
        return 'Unexpected error occurred. Please try again later.';
      default:
        return 'Unknown error occurred.';
    }
  }
}