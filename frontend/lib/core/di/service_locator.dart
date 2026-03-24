import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fakegram/core/utils/platform_utils.dart';
import 'package:fakegram/features/auth/data/datasources/local/user_local_datasource.dart';
import 'package:fakegram/features/auth/data/datasources/local/user_local_datasource_impl.dart';
import 'package:fakegram/features/auth/domain/repositories/auth_repository.dart';
import 'package:fakegram/features/auth/domain/services/user_service.dart';
import 'package:fakegram/features/auth/domain/services/user_service_impl.dart';
import 'package:fakegram/features/chat/data/datasource/remote/message_datasource.dart';
import 'package:fakegram/features/chat/domain/repositories/message_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/auth/data/datasources/local/auth_local_datasource.dart';
import '../../features/auth/data/datasources/local/auth_local_datasource_impl.dart';
import '../../features/auth/data/datasources/remote/auth_datasource.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/services/token_service.dart';
import '../../features/auth/domain/services/token_service_impl.dart';
import '../../features/chat/data/datasource/remote/chat_datasource.dart';
import '../../features/chat/data/repositories/chat_repository_impl.dart';
import '../../features/chat/data/repositories/message_repository_impl.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/websocket/data/repository/websocket_repository_impl.dart';
import '../../features/websocket/data/service/websocket_service.dart';
import '../../features/websocket/data/service/websocket_service_impl.dart';
import '../../features/websocket/domain/repository/websocket_repository.dart';
import '../network/dio_client.dart';
import '../network/interceptors/logging_interceptor.dart';

final getIt = GetIt.instance;
const _baseUrl = 'http://127.0.0.1:8080/api/v1'; // 'http://10.0.2.2:8080/api/v1';

Future<void> initDependencies() async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(
      () => sharedPreferences,
  );

  // LocalDatasource
  getIt.registerLazySingleton<AuthLocalDatasource>(
        () => AuthLocalDatasourceImpl(
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<UserLocalDatasource>(
        () => UserLocalDatasourceImpl(
      prefs: getIt<SharedPreferences>(),
    ),
  );

  //Service
  getIt.registerLazySingleton<TokenService>(
        () {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: _baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      refreshDio.interceptors.add(LoggingInterceptor());

      return TokenServiceImpl(
        localDataSource: getIt<AuthLocalDatasource>(),
        dio: refreshDio,
      );
    },
  );

  getIt.registerLazySingleton<UserService>(
        () {
      return UserServiceImpl(
        userLocalDatasource: getIt<UserLocalDatasource>(),
      );
    },
  );

  getIt.registerLazySingleton<WebSocketService>(
        () => WebSocketServiceImpl(),
  );

  getIt.registerLazySingleton<DioClient>(
        () => DioClient(
      tokenService: getIt<TokenService>(),
      baseUrl: _baseUrl,
    ),
  );

  // Remote datasource
  getIt.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasource(
      getIt<DioClient>().instance,
      baseUrl: _baseUrl,
    ),
  );

  getIt.registerLazySingleton<MessageRemoteDatasource>(
        () => MessageRemoteDatasource(
          getIt<DioClient>().instance,
          baseUrl: _baseUrl,
    ),
  );

  getIt.registerLazySingleton<ChatRemoteDatasource>(
        () => ChatRemoteDatasource(
      getIt<DioClient>().instance,
      baseUrl: _baseUrl,
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      authRemoteDatasource: getIt<AuthRemoteDatasource>(),
      authLocalDatasource: getIt<AuthLocalDatasource>(),
      userLocalDatasource: getIt<UserLocalDatasource>(),
      tokenService: getIt<TokenService>(),
    ),
  );

  getIt.registerLazySingleton<ChatRepository>(
        () => ChatRepositoryImpl(
      remoteDataSource: getIt<ChatRemoteDatasource>(),
      tokenService: getIt<TokenService>(),
    ),
  );

  getIt.registerLazySingleton<MessageRepository>(
        () => MessageRepositoryImpl(
      remoteDataSource: getIt<MessageRemoteDatasource>(),
      tokenService: getIt<TokenService>(),
    ),
  );
  getIt.registerLazySingleton<WebSocketRepository>(
        () => WebSocketRepositoryImpl(
      webSocketService: getIt<WebSocketService>(),
      tokenService: getIt<TokenService>(),
    ),
  );
}