import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/data/datasources/remote/auth_datasource.dart';
import 'package:fakegram/features/auth/domain/services/token_service.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../domain/entities/auth_result_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../models/request/login_request_dto.dart';
import '../models/request/registration_request_dto.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDataSource;
  final AuthLocalDatasource _localDataSource;
  final TokenService _tokenService;

  AuthRepositoryImpl({
    required AuthRemoteDatasource remoteDataSource,
    required AuthLocalDatasource localDataSource,
    required TokenService tokenService,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _tokenService = tokenService;

  @override
  Future<AuthResultEntity> login({
    required String email,
    required String password,
  }) async {
    try {
      final request = LoginRequestDTO(email: email, password: password)
          .toJson();
      final response = await _remoteDataSource.login(request);
      final authResult = response.toEntity();

      await _localDataSource.saveToken(authResult.token);

      return authResult;
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String nickname
  }) async {
    try{
      final request = RegistrationRequestDTO(
          email: email,
          password: password,
          name: name,
          surname: surname,
          nickname: nickname
      ).toJson();

      await _remoteDataSource.registration(request);
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  @override
  Future<void> logout() async {
    await _localDataSource.deleteToken();
  }

  @override
  Future<void> refreshTokenUpdate() async {
    await _tokenService.updateToken();
  }
}