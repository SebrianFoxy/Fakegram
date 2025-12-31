import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/data/models/request/login_request_dto.dart';
import 'package:fakegram/features/auth/data/models/response/login_response_dto.dart';
import 'package:fakegram/features/auth/data/models/response/registration_response_dto.dart';
import 'package:fakegram/features/auth/data/models/response/token_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_datasource.g.dart';

@RestApi()
abstract class AuthRemoteDatasource {
  factory AuthRemoteDatasource(Dio dio, {String baseUrl}) = _AuthRemoteDatasource;

  @POST('/auth/login')
  Future<LoginResponseDTO> login(@Body() Map<String, dynamic> request);

  @POST('/auth/registration')
  Future<RegistrationResponseDTO> registration(@Body() Map<String, dynamic> request);

  @POST('/auth/refresh')
  Future<TokenResponseDTO> refreshToken(@Body() Map<String, dynamic> request);
}