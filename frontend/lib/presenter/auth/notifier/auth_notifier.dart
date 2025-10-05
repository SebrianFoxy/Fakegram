import 'package:dio/dio.dart';
import 'package:fakegram/data/dio_error_handlers/error_handlers.dart';
import 'package:fakegram/data/dto_s/login/login_request/login_request_dto.dart';
import 'package:fakegram/data/dto_s/login/login_response/login_response_dto.dart';
import 'package:fakegram/presenter/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';
part 'auth_state.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return const AuthState.initial();
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final request = LoginRequestDTO(email: email, password: password).toJson();
      final user = await authRepository.login(request);

      state = AuthState.authenticated(user: user);
    } on DioException catch(error) {
      debugPrint('LoginError: $error');
      final errorMessage = ErrorHandler.handleDioError(error);
      state = AuthState.error(error: errorMessage);
      state = AuthState.initial();
    }
  }

}