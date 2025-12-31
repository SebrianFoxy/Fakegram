import 'package:dio/dio.dart';
import '../../features/auth/domain/services/token_service.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/token_interceptor.dart';

class DioClient {
  final Dio _dio;

  DioClient({
    required TokenService tokenService,
    String baseUrl = 'http://127.0.0.1:8080/api/v1',
  }) : _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    sendTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  )) {
    _setupInterceptors(tokenService);
  }

  void _setupInterceptors(TokenService tokenService) {
    _dio.interceptors.add(LoggingInterceptor());
    _dio.interceptors.add(
      TokenInterceptor(
        tokenService: tokenService,
        dio: _dio,
      ),
    );

  }

  Dio get instance => _dio;
}