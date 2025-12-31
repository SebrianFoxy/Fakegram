import '../entities/auth_result_entity.dart';

abstract class AuthRepository {
  Future<AuthResultEntity> login({
    required String email,
    required String password
  });
  Future<void> register({
    required String email,
    required String password,
    required String name,
    required String surname,
    required String nickname,
  });
  Future<void> logout();
  Future<void> refreshTokenUpdate();
}