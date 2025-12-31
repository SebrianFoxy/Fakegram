abstract class AppException implements Exception {
  final String message;
  final int? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(String message) : super(message);
}

class NoInternetException extends NetworkException {
  const NoInternetException() : super('No internet connection');
}

class TimeoutException extends NetworkException {
  const TimeoutException() : super('Request timeout');
}

class ServerException extends AppException {
  final int statusCode;

  const ServerException(String message, this.statusCode)
      : super(message, code: statusCode);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException(String message) : super(message);
}

class ValidationException extends AppException {
  const ValidationException(String message) : super(message);
}

class LocalStorageException extends AppException {
  const LocalStorageException(String message) : super(message);
}