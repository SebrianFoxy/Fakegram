import '../../../domain/entities/token_entity.dart';

abstract class AuthLocalDatasource {
  Future<void> saveToken(TokenEntity token);
  Future<TokenEntity?> getToken();
  Future<void> deleteToken();
  Future<String?> getAccessToken();
  Future<String?> getRefreshToken();
}