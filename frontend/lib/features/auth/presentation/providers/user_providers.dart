import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/services/user_service.dart';

part 'user_providers.g.dart';

@riverpod
class CurrentUserId extends _$CurrentUserId {
  @override
  String? build() {
    _loadUserId();
    return null;
  }

  Future<void> _loadUserId() async {
    final userService = getIt<UserService>();
    final userId = await userService.getUserId();
    state = userId;
  }

  void setUserId(String? userId) {
    state = userId;
  }

  void clear() {
    state = null;
  }
}