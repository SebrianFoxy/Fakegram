import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../presenter/auth/notifier/auth_notifier.dart';
import '../../secure_storage/secure_storage.dart';

class TokenInterceptor extends Interceptor {
  final Ref ref;
  bool _isRefreshing = false;
  final List<RequestOptions> _pendingRequests = [];

  TokenInterceptor(this.ref);

  @override
  Future<void> onRequest(RequestOptions options,
      RequestInterceptorHandler handler,) async {
    final token = await SecureStorage().readSecureData('accessToken');
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioException err,
      ErrorInterceptorHandler handler,) async {
    if (err.response?.statusCode == 401 && !_isRefreshing) {
      _pendingRequests.add(err.requestOptions);
      final authNotifier = ref.read(authNotifierProvider.notifier);

      try {
        _isRefreshing = true;
        await authNotifier.tokenUpdate(false);

        for (var options in _pendingRequests) {
          final newToken = await SecureStorage().readSecureData('accessToken');
          options.headers['Authorization'] = 'Bearer $newToken';

          try {
            final response = await Dio().fetch(options);
          } catch (e) {
            debugPrint('Retry request failed: $e');
          }
        }
      } catch (e) {
        await authNotifier.logout();
      } finally {
        _isRefreshing = false;
        _pendingRequests.clear();
      }
    }

    handler.next(err);
  }
}