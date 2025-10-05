import 'package:dio/dio.dart';
import 'package:fakegram/data/dto_s/login/login_request/login_request_dto.dart';
import 'package:fakegram/data/dto_s/login/login_response/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_datasource.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8080/api/v1')
abstract class AuthDatasource {
  factory AuthDatasource(Dio dio) = _AuthDatasource;

  @POST('/auth/login')
  Future<LoginResponseDTO> login(@Body() Map<String, dynamic> request);
}