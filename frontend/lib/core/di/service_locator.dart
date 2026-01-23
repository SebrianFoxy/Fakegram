import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/domain/repositories/auth_repository.dart';
import 'package:fakegram/features/chat/data/datasource/remote/message_datasource.dart';
import 'package:fakegram/features/chat/domain/repositories/message_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
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

Future<void> initDependencies() async {
  getIt.registerLazySingleton<FlutterSecureStorage>(
        () => const FlutterSecureStorage(),
  );

  getIt.registerLazySingleton<AuthLocalDatasource>(
        () => AuthLocalDatasourceImpl(
      secureStorage: getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton<TokenService>(
        () {
      final refreshDio = Dio(
        BaseOptions(
          baseUrl: 'http://127.0.0.1:8080/api/v1',
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

  getIt.registerLazySingleton<WebSocketService>(
        () => WebSocketServiceImpl(),
  );

  getIt.registerLazySingleton<DioClient>(
        () => DioClient(
      tokenService: getIt<TokenService>(),
      baseUrl: 'http://127.0.0.1:8080/api/v1',
    ),
  );

  // Remote datasource
  getIt.registerLazySingleton<AuthRemoteDatasource>(
        () => AuthRemoteDatasource(
      getIt<DioClient>().instance,
      baseUrl: 'http://127.0.0.1:8080/api/v1',
    ),
  );

  getIt.registerLazySingleton<MessageRemoteDatasource>(
        () => MessageRemoteDatasource(
          getIt<DioClient>().instance,
          baseUrl: 'http://127.0.0.1:8080/api/v1',
    ),
  );

  getIt.registerLazySingleton<ChatRemoteDatasource>(
        () => ChatRemoteDatasource(
      getIt<DioClient>().instance,
      baseUrl: 'http://127.0.0.1:8080/api/v1',
    ),
  );

  // Repository
  getIt.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDatasource>(),
      localDataSource: getIt<AuthLocalDatasource>(),
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