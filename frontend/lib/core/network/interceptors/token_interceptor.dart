import 'dart:async';
import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/domain/services/token_service.dart';

class TokenInterceptor extends Interceptor {
  final TokenService _tokenService;
  final Dio _dio;

  bool _isRefreshing = false;
  final List<({RequestOptions options, Completer<Response> completer})>
  _pendingRequests = [];

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
      _pendingRequests.add((
      options: err.requestOptions,
      completer: Completer<Response>(),
      ));

      await _handleTokenRefresh();

      final newToken = await _tokenService.getAccessToken();

      if (newToken != null) {
        try {
          final response = await _retryRequest(err.requestOptions, newToken);
          handler.resolve(response);
          return;
        } catch (e) {
          handler.reject(DioException(
            requestOptions: err.requestOptions,
            error: e,
          ));
          return;
        }
      } else {
        handler.reject(err);
        return;
      }
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

  Future<void> _handleTokenRefresh() async {
    if (_isRefreshing) return;

    _isRefreshing = true;

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
        pending.completer.complete(response);
      } catch (e) {
        pending.completer.completeError(e);
      }
    }
  }

  void _rejectPendingRequests(dynamic error) {
    for (final pending in _pendingRequests) {
      pending.completer.completeError(error);
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