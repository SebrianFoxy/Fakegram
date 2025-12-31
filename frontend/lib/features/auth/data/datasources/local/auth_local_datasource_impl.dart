import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../domain/entities/token_entity.dart';
import 'auth_local_datasource.dart';
import 'auth_local_storage_exceptions.dart';

class AuthLocalDatasourceImpl implements AuthLocalDatasource {
  final FlutterSecureStorage _secureStorage;

  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

  AuthLocalDatasourceImpl({required FlutterSecureStorage secureStorage})
      : _secureStorage = secureStorage;

  @override
  Future<void> saveToken(TokenEntity token) async {
    try {
      await _secureStorage.write(
          key: _accessTokenKey,
          value: token.accessToken
      );
      await _secureStorage.write(
          key: _refreshTokenKey,
          value: token.refreshToken
      );
    } catch (e) {
      throw LocalStorageException('Failed to save token: $e');
    }
  }

  @override
  Future<TokenEntity?> getToken() async {
    try {
      final accessToken = await _secureStorage.read(key: _accessTokenKey);
      final refreshToken = await _secureStorage.read(key: _refreshTokenKey);

      if (accessToken == null || refreshToken == null) {
        return null;
      }

      try {
        return TokenEntity(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      } catch (e) {
        await deleteToken();
        return null;
      }
    } catch (e) {
      throw LocalStorageException('Failed to get token: $e');
    }
  }

  @override
  Future<void> deleteToken() async {
    try {
      await _secureStorage.delete(key: _accessTokenKey);
      await _secureStorage.delete(key: _refreshTokenKey);
    } catch (e) {
      throw LocalStorageException('Failed to delete token: $e');
    }
  }

  @override
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  @override
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }
}