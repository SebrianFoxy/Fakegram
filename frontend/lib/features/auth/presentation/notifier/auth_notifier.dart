import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/data/datasources/local/user_local_datasource.dart';
import 'package:fakegram/features/auth/domain/repositories/auth_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../../core/network/error_handling/exceptions.dart';
import '../../../chat/presentation/notifier/chat/chat_notifier.dart';
import '../../../chat/presentation/notifier/message/message_notifier.dart';
import '../../../websocket/presentation/notifier/websocket_notifier.dart';
import '../providers/user_providers.dart';

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
      await getIt<AuthRepository>().refreshTokenUpdate();

      state = AuthState.authenticated();

      await Future.delayed(const Duration(milliseconds: 100));

      ref.read(webSocketProvider.notifier).connect();
    } on AppException catch(error) {
      debugPrint('Auth check failed: ${error.message}');
      state = AuthState.initial();
    } on DioException catch(error) {
      debugPrint('CheckAuthError: $error');
      if (error.response?.statusCode == 401) {
        await getIt<AuthRepository>().logout();
        state = AuthState.initial();
      }
      else{
        state = AuthState.initial();
      }
    } catch (error) {
      debugPrint('LoginError: $error');
      state = AuthState.initial();
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    try {
      final authRepository = getIt<AuthRepository>();
      final result = await authRepository.login(email: email, password: password);

      ref.read(currentUserIdProvider.notifier).setUserId(result.user.id);

      state = AuthState.authenticated();

      await Future.delayed(const Duration(milliseconds: 50));
      ref.read(webSocketProvider.notifier).connect();
    } on DioException catch(error) {
      final exception = ErrorHandler.handleDioError(error);
      state = AuthState.initial(error: exception.message);
    } catch (error) {
      final exception = ErrorHandler.handleError(error);
      state = AuthState.initial(error: exception.message);
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
      final authRepository = getIt<AuthRepository>();

      await authRepository.register(
          email: email,
          password: password,
          name: firstName,
          surname: lastName,
          nickname: nickname
      );

      state = AuthState.registrationSuccess();
      state = AuthState.initial();
    } catch (error) {
      debugPrint('RegistrationError: $error');
      final exception = ErrorHandler.handleError(error);
      state = AuthState.initial(error: exception.message);
    }
  }

  Future<void> logout() async {
    try {
      await ref.read(webSocketProvider.notifier).disconnect();

      await getIt<UserLocalDatasource>().deleteUserInfo();
      await getIt<AuthRepository>().logout();

      ref.read(currentUserIdProvider.notifier).clear();

      state = const AuthState.initial();
    } catch (error) {
      debugPrint('LogoutError: $error');
      state = const AuthState.initial();
    }
  }
}
