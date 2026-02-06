import 'dart:convert';
import 'package:fakegram/features/auth/data/datasources/local/user_local_datasource.dart';
import 'package:fakegram/features/auth/domain/entities/user_entity.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocalDatasourceImpl implements UserLocalDatasource {
  final SharedPreferences _prefs;

  static const String _userIdKey = 'user_id';
  static const String _userJsonInformation = 'user_json';

  UserLocalDatasourceImpl({required SharedPreferences prefs})
      : _prefs = prefs;

  @override
  Future<void> saveCurrentUserId(String userId) async {
    await _prefs.setString(_userIdKey, userId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return _prefs.getString(_userIdKey);
  }

  @override
  Future<void> saveCurrentUser(UserEntity user) async {
    final userJson = {
      'id': user.id,
      'email': user.email,
      'name': user.name,
      'surname': user.surname,
      'nickname': user.nickname,
      'approved': user.approved,
    };

    await _prefs.setString(_userJsonInformation, jsonEncode(userJson));
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    final userJson = _prefs.getString(_userJsonInformation);
    if (userJson == null) {
      debugPrint('No user data found');
      return null;
    }

    final userMap = jsonDecode(userJson) as Map<String, dynamic>;

    return UserEntity(
      id: userMap['id'] as String,
      email: userMap['email'] as String,
      name: userMap['name'] as String,
      surname: userMap['surname'] as String,
      nickname: userMap['nickname'] as String,
      approved: userMap['approved'] as bool,
    );
  }

  @override
  Future<void> deleteUserInfo() async {
    try {
      await _prefs.remove(_userIdKey);
      await _prefs.remove(_userJsonInformation);
    } catch (e) {
      debugPrint('DeleteUserError: $e');
    }
  }
}