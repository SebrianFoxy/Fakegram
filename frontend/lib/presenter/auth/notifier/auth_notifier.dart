import 'package:dio/dio.dart';
import 'package:fakegram/data/dio_error_handlers/error_handlers.dart';
import 'package:fakegram/data/dto_s/login/login_request/login_request_dto.dart';
import 'package:fakegram/data/dto_s/registration/registration_request/registration_request_dto.dart';
import 'package:fakegram/data/dto_s/token/token_request/token_request_dto.dart';
import 'package:fakegram/presenter/auth/repository/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/secure_storage/secure_storage.dart';

part 'auth_notifier.freezed.dart';
part 'auth_notifier.g.dart';
part 'auth_state.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    _checkAuth();
    return const AuthState.loading();
  }

  Future<void> _checkAuth() async {
    try{
      final refreshToken = await SecureStorage().readSecureData('refreshToken');

      if (refreshToken != null && refreshToken.isNotEmpty) {
       await tokenUpdate(true);
       state = AuthState.authenticated();
      }
      else{
        state = AuthState.initial();
      }
    } on DioException catch(error) {
      debugPrint('CheckAuthError: $error');
      if (error.response?.statusCode == 401) {
        await _clearTokens();
        state = AuthState.initial();
      }
      else{
        state = AuthState.initial();
      }
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final authRepository = ref.read(authRepositoryProvider);
      final request = LoginRequestDTO(email: email, password: password).toJson();
      final user = await authRepository.login(request);

      await SecureStorage().writeSecureData('refreshToken', user.token.refreshToken);
      await SecureStorage().writeSecureData('accessToken', user.token.accessToken);

      state = AuthState.authenticated();
    } on DioException catch(error) {
      debugPrint('LoginError: $error');
      final errorMessage = ErrorHandler.handleDioError(error);

      state = AuthState.initial(error: errorMessage);
    }
  }

  Future<void> registration(
      String email,
      String firstName,
      String lastName,
      String nickname,
      String password,) async {
    state = const AuthState.loading();
    try{
      final authRepository = ref.read(authRepositoryProvider);
      final request = RegistrationRequestDTO(
          email: email,
          name: firstName,
          surname: lastName,
          nickname: nickname,
          password: password
      ).toJson();
      await authRepository.registration(request);

      state = AuthState.registrationSuccess();
      state = AuthState.initial();
    } on DioException catch(error) {
      debugPrint('RegistrationError: $error');
      final errorMessage = ErrorHandler.handleDioError(error);

      state = AuthState.initial(error: errorMessage);
    }
  }

  Future<void> tokenUpdate(bool refreshRotate) async {
    try{
      final authRepository = ref.read(authRepositoryProvider);
      final refreshToken = await SecureStorage().readSecureData('refreshToken');
      final request = TokenRequestDTO(
          refreshRotate: refreshRotate,
          refreshToken: refreshToken
      ).toJson();
      final newTokens = await authRepository.tokenUpdate(request);

      if (refreshRotate) {
        await SecureStorage().writeSecureData('refreshToken', newTokens.token.refreshToken);
        await SecureStorage().writeSecureData('accessToken', newTokens.token.accessToken);
      }
      else {
        await SecureStorage().writeSecureData('accessToken', newTokens.token.accessToken);
      }
    } on DioException catch(error) {
      debugPrint('TokenError: $error');
      rethrow;
    }
  }

  Future<void> _clearTokens() async {
    await SecureStorage().deleteSecureData('refreshToken');
    await SecureStorage().deleteSecureData('accessToken');
  }

  Future<void> logout() async {
    try {
      await _clearTokens();
      state = const AuthState.initial();
    } catch (error) {
      debugPrint('LogoutError: $error');
    }
  }
}