import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatUpdateProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final newChatProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final newMessageProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final messageReadProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final typingStatusProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

final userOnlineStatusProvider = StateProvider<Map<String, dynamic>?>((ref) => null);