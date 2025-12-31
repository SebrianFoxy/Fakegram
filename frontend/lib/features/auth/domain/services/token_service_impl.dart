import 'package:dio/dio.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../../core/network/error_handling/exceptions.dart';
import '../../data/datasources/local/auth_local_datasource.dart';
import '../../data/datasources/remote/auth_datasource.dart';
import '../../data/models/request/token_request_dto.dart';
import '../entities/token_entity.dart';
import 'token_service.dart';

class TokenServiceImpl implements TokenService {
  final AuthLocalDatasource _localDataSource;
  final Dio _dio;

  TokenServiceImpl({
    required AuthLocalDatasource localDataSource,
    required Dio dio,
  })  : _localDataSource = localDataSource,
        _dio = dio;

  AuthRemoteDatasource get _remoteDataSource =>
      AuthRemoteDatasource(_dio, baseUrl: _dio.options.baseUrl);

  @override
  Future<String?> getAccessToken() async {
    final token = await _localDataSource.getToken();
    return token?.accessToken;
  }

  @override
  Future<void> deleteTokens() async {
    await _localDataSource.deleteToken();
  }

  @override
  Future<void> updateToken() async {
    try{
      final refreshToken = await _localDataSource.getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        throw UnauthorizedException('No refresh token found');
      }

      final request = TokenRequestDTO(
          refreshRotate: true,
          refreshToken: refreshToken
      ).toJson();

      final response = await _remoteDataSource.refreshToken(request);
      final token = response.token.toEntity();

      await _localDataSource.saveToken(token);
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }
}