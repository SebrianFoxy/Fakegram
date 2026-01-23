import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/domain/services/token_service.dart';

class TokenInterceptor extends Interceptor {
  final TokenService _tokenService;
  final Dio _dio;

  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})> _pendingRequests = [];

  TokenInterceptor({
    required TokenService tokenService,
    required Dio dio,
  })  : _tokenService = tokenService,
        _dio = dio;

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _tokenService.getAccessToken();

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if (_shouldRefreshToken(err)) {
      final completer = Completer<void>();
      _pendingRequests.add((options: err.requestOptions, handler: handler));

      if (!_isRefreshing) {
        _isRefreshing = true;
        _refreshTokenAndRetry();
      }

      await completer.future;
      return;
    }

    handler.next(err);
  }

  bool _shouldRefreshToken(DioException err) {
    return err.response?.statusCode == 401 &&
        !_isRefreshing &&
        !_isRefreshEndpoint(err.requestOptions.path);
  }

  bool _isRefreshEndpoint(String path) {
    return path.contains('/auth/refresh');
  }

  Future<void> _refreshTokenAndRetry() async {
    try {
      await _tokenService.updateToken();

      await _retryPendingRequests();
    } catch (e) {
      await _tokenService.deleteTokens();
      _rejectPendingRequests(e);
    } finally {
      _isRefreshing = false;
      _pendingRequests.clear();
    }
  }

  Future<void> _retryPendingRequests() async {
    final newToken = await _tokenService.getAccessToken();

    if (newToken == null) {
      _rejectPendingRequests(Exception('No token after refresh'));
      return;
    }

    for (final pending in _pendingRequests) {
      try {
        final response = await _retryRequest(pending.options, newToken);
        pending.handler.resolve(response);
      } catch (e) {
        pending.handler.reject(DioException(
          requestOptions: pending.options,
          error: e,
        ));
      }
    }
  }

  void _rejectPendingRequests(dynamic error) {
    for (final pending in _pendingRequests) {
      pending.handler.reject(DioException(
        requestOptions: pending.options,
        error: error,
      ));
    }
  }

  Future<Response> _retryRequest(
      RequestOptions options,
      String newToken
      ) async {
    final newOptions = Options(
      method: options.method,
      headers: {
        ...options.headers,
        'Authorization': 'Bearer $newToken',
      },
      contentType: options.contentType,
      responseType: options.responseType,
      receiveDataWhenStatusError: options.receiveDataWhenStatusError,
      extra: options.extra,
      validateStatus: options.validateStatus,
      receiveTimeout: options.receiveTimeout,
      sendTimeout: options.sendTimeout,
    );

    return await _dio.request<dynamic>(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: newOptions,
    );
  }
}