import 'package:fakegram/data/dto_s/chat/chat_response/chat_response_dto.dart';
import 'package:fakegram/data/models/direct_chat/direct_chat_model.dart';
import 'package:fakegram/data/secure_storage/secure_storage.dart';
import 'package:fakegram/presenter/chat/repository/chat/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../data/models/direct_message/direct_message_model.dart';
import '../../../websocket/notifier/websocket_notifier.dart';
import '../../../websocket/providers/websocket_providers.dart';

part 'chat_notifier.freezed.dart';
part 'chat_notifier.g.dart';
part 'chat_state.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  @override
  ChatState build() {
    _initializeWebSocket();
    loadChats();
    return state;
  }

  void _initializeWebSocket() {
    ref.listen(chatUpdateProvider, (previous, next) {
      if (next != null && state is ChatStateSuccessLoading) {
        _updateChatInList(next);
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(webSocketNotifierProvider.notifier).connect();
    });
  }

  Future<void> loadChats() async {
    state = const ChatState.loading();
    try {
      final token = await SecureStorage().readSecureData('accessToken');
      final chats = await ref.read(chatRepositoryProvider).getChats(token);

      state = ChatState.successLoading(chats: chats);
    } catch (error) {
      debugPrint("LoadChatsError: $error");
      state = ChatState.successLoading(
        chats: ChatResponseDTO(chats: [], count: 0),
        error: error.toString(),
      );
    }
  }

  void _updateChatInList(Map<String, dynamic> chatData) {
    debugPrint("🎯 _updateChatInList CALLED!");

    final currentState = state;
    if (currentState is ChatStateSuccessLoading) {
      try {
        if (chatData['chat'] != null) {
          final chatJson = chatData['chat'] as Map<String, dynamic>;
          final updatedChat = DirectChatModel.fromJson(chatJson);

          debugPrint("🎯 Processing chat: ${updatedChat.id}");

          final existingChatIndex = currentState.chats.chats.indexWhere(
                  (chat) => chat.id == updatedChat.id
          );

          List<DirectChatModel> updatedChatsList;

          if (existingChatIndex != -1) {
            debugPrint("🎯 Updating existing chat at index $existingChatIndex");
            updatedChatsList = List.from(currentState.chats.chats);
            updatedChatsList[existingChatIndex] = updatedChat;
          } else {
            debugPrint("🎯 Adding NEW chat to beginning");
            updatedChatsList = [updatedChat, ...currentState.chats.chats];
          }

          updatedChatsList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

          final updatedChatResponse = currentState.chats.copyWith(
            chats: updatedChatsList,
          );

          state = currentState.copyWith(chats: updatedChatResponse);

          debugPrint("🎯 ✅ Chat list updated successfully! Total: ${updatedChatsList.length}");
        }
      } catch (e) {
        debugPrint("🔴 Error in _updateChatInList: $e");
      }
    } else {
      debugPrint("🔴 Cannot update - wrong state: $currentState");
    }
  }
}

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
