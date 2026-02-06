import 'dart:async';
import 'dart:convert';
import 'package:fakegram/features/auth/data/datasources/local/user_local_datasource.dart';
import 'package:fakegram/features/auth/domain/entities/user_entity.dart';
import 'package:fakegram/features/auth/domain/services/user_service.dart';
import '../../data/datasources/local/auth_local_storage_exceptions.dart';

class UserServiceImpl implements UserService {
  final UserLocalDatasource _userLocalDatasource;

  UserServiceImpl({
    required UserLocalDatasource userLocalDatasource,
  })  : _userLocalDatasource = userLocalDatasource;

  @override
  Future<String?> getUserId() async {
    final userId = await _userLocalDatasource.getCurrentUserId();
    return userId;
  }

  @override
  Future<void> saveUserId(String userId) async {
    try {
      await _userLocalDatasource.saveCurrentUserId(userId);
    } catch (e) {
      throw LocalStorageException('Failed to save userId: $e');
    }
  }

  @override
  Future<void> saveCurrentUser(UserEntity user) async {
    try {
      await _userLocalDatasource.saveCurrentUser(user);
    } catch (e) {
      throw LocalStorageException('Failed to save data user: $e');
    }
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    try {
      return await _userLocalDatasource.getCurrentUser();
    } catch (e) {
      throw LocalStorageException('Failed to get data user: $e');
    }
  }
}