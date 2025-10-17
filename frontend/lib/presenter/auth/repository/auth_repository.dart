import 'package:dio/dio.dart';
import 'package:fakegram/data/datasource/auth/auth_datasource.dart';
import 'package:fakegram/data/dto_s/login/login_response/login_response_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../data/dto_s/token/token_response/token_response_dto.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(Ref ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (log) => debugPrint('Dio: $log'),
  ));

  final authDatasource = AuthDatasource(dio);
  return AuthRepository(authDatasource);
}

class AuthRepository {
  final AuthDatasource _datasource;

  AuthRepository(this._datasource);

  Future<LoginResponseDTO> login(dynamic request) async {
    try {
      return await _datasource.login(request);
    } on DioException catch(error) {
      debugPrint('AuthRepositoryERROR: $error');
      rethrow;
    }
  }

  Future<void> registration(dynamic request) async {
    try{
      await _datasource.registration(request);
    } on DioException catch(error) {
      debugPrint('AuthRepositoryERROR: $error');
      rethrow;
    }
  }

  Future<TokenResponseDTO> tokenUpdate(dynamic request) async {
    try {
      return await _datasource.refreshToken(request);
    } on DioException catch (error) {
      debugPrint('AuthRepositoryERROR: $error');
      rethrow;
    }
  }
}