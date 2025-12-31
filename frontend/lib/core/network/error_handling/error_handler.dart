import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'exceptions.dart';

class ErrorHandler {
  static AppException handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeoutException();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return NetworkException('Request cancelled');

      case DioExceptionType.connectionError:
        if (error.error is SocketException) {
          return NoInternetException();
        }
        return NetworkException('Connection error');

      case DioExceptionType.badCertificate:
        return NetworkException('Bad certificate');

      case DioExceptionType.unknown:
        return NetworkException('Unknown network error');

      default:
        return NetworkException('Network error');
    }
  }

  static AppException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode ?? 500;
    final responseData = error.response?.data;

    switch (statusCode) {
      case 400:
        final message = _extractErrorMessage(responseData) ?? 'Bad request';
        return ValidationException(message);

      case 401:
        final message = _extractErrorMessage(responseData) ?? 'Unauthorized';
        return UnauthorizedException(message);

      case 403:
        final message = _extractErrorMessage(responseData) ?? 'Forbidden';
        return UnauthorizedException(message);

      case 404:
        return NetworkException('Resource not found');

      case 409:
        final message = _extractErrorMessage(responseData) ?? 'Conflict occurred';
        return ValidationException(message);

      case 422:
        final message = _extractErrorMessage(responseData) ?? 'Validation error';
        return ValidationException(message);

      case 429:
        return NetworkException('Too many requests');

      case 500:
      case 502:
      case 503:
      case 504:
        return ServerException('Server error', statusCode);

      default:
        return ServerException('Server error', statusCode);
    }
  }

  static String? _extractErrorMessage(dynamic responseData) {
    if (responseData is Map<String, dynamic>) {
      return responseData['message']?.toString() ??
          responseData['error']?.toString() ??
          responseData['detail']?.toString();
    }
    return null;
  }

  static AppException handleError(dynamic error) {
    if (error is DioException) {
      return handleDioError(error);
    } else if (error is AppException) {
      return error;
    } else if (error is String) {
      return NetworkException(error);
    } else {
      return NetworkException('An unexpected error occurred');
    }
  }
}
