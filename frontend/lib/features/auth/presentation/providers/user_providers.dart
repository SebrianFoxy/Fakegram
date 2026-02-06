import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../domain/services/user_service.dart';

part 'user_providers.g.dart';

@riverpod
Future<String?> currentUserId(Ref ref) async {
  final userService = getIt<UserService>();
  return await userService.getUserId();
}