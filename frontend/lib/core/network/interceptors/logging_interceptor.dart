import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggingInterceptor extends Interceptor {
  final Logger _logger;

  LoggingInterceptor({Logger? logger})
      : _logger = logger ?? Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 50,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.i('🌐 Request: ${options.method} ${options.path}');
    if (options.data != null) {
      _logger.d('📦 Request Body: ${options.data}');
    }
    if (options.headers.isNotEmpty) {
      _logger.d('📋 Headers: ${_maskSensitiveHeaders(options.headers)}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('✅ Response: ${response.statusCode} ${response.requestOptions.path}');
    _logger.d('📄 Response Body: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.e('❌ Error: ${err.type} | ${err.response?.statusCode}');
    _logger.e('Path: ${err.requestOptions.path}');
    if (err.response?.data != null) {
      _logger.e('Error Body: ${err.response?.data}');
    }
    handler.next(err);
  }

  Map<String, dynamic> _maskSensitiveHeaders(Map<String, dynamic> headers) {
    final masked = Map<String, dynamic>.from(headers);

    if (masked.containsKey('Authorization')) {
      final auth = masked['Authorization'] as String?;
      if (auth != null && auth.length > 10) {
        masked['Authorization'] = '${auth.substring(0, 10)}...';
      }
    }

    return masked;
  }
}