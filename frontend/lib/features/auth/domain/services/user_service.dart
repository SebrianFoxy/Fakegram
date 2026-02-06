import 'package:fakegram/features/auth/domain/entities/user_entity.dart';

abstract class UserService {
  Future<String?> getUserId();
  Future<void> saveUserId(String userId);
  Future<void> saveCurrentUser(UserEntity user);
  Future<UserEntity?> getCurrentUser();
}
