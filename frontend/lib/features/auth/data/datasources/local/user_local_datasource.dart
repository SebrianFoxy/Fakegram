import 'package:fakegram/features/auth/domain/entities/user_entity.dart';

abstract class UserLocalDatasource {
  Future<String?> getCurrentUserId();
  Future<void> saveCurrentUserId(String userId);
  Future<void> saveCurrentUser(UserEntity user);
  Future<UserEntity?> getCurrentUser();
  Future<void> deleteUserInfo();
}