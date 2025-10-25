import 'package:fakegram/data/models/direct_chat/direct_chat_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../data/models/direct_message/direct_message_model.dart';

part 'messages_notifier.freezed.dart';
// part 'messages_notifier.g.dart';
part 'messages_state.dart';

// @riverpod
// class MessagesNotifier extends _$MessagesNotifier {
//   @override
//   MessagesState build() {
//     return const MessagesState.initial();
//   }
// }

final chatListProvider = Provider<List<DirectChatModel>>((ref) {
  return [
    DirectChatModel(
      id: '1',
      otherUserId: '1',
      otherUserName: 'Анна Петрова',
      lastMessage: 'Привет! Как дела?',
      lastMessageTime: '12:30',
      otherUserAvatar: 'assets/default-avatar.png',
      unreadCount: 2,
      isOnline: true,
    ),
    DirectChatModel(
      id: '2',
      otherUserId: '2',
      otherUserName: 'Старая Вэльма',
      lastMessage: 'Привет!?',
      lastMessageTime: '12:30',
      otherUserAvatar: 'assets/default-avatar.png',
      unreadCount: 2,
      isOnline: true,
    ),
  ];
});

final selectedChatProvider = StateProvider<DirectChatModel?>((ref) => null);

final chatMessagesProvider = StateProvider.family<List<DirectMessageModel>, String>((ref, chatId) {
  final now = DateTime.now();
  return [
    DirectMessageModel(
      id: '1',
      senderId: 'system',
      receiverId: 'current_user',
      text: 'Начало чата',
      createdAt: now.subtract(const Duration(minutes: 30)),
      isRead: true,
      isDelivered: true,
    ),
  ];
});
