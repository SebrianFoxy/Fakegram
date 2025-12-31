import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/data/models/direct_chat_model.dart';
import 'package:fakegram/features/chat/domain/entities/direct_chat_entity.dart';
import 'package:fakegram/features/chat/domain/entities/direct_message_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../websocket/presentation/notifier/websocket_notifier.dart';
import '../../../websocket/presentation/providers/websocket_providers.dart';

part 'chat_notifier.freezed.dart';
part 'chat_notifier.g.dart';
part 'chat_state.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  late ChatRepository _chatRepository;

  @override
  ChatState build() {
    _chatRepository = getIt<ChatRepository>();
    _initializeWebSocket();
    loadChats();
    return state;
  }

  void _initializeWebSocket() {
    ref.listen(
      chatUpdateProvider,
          (previous, next) {
        if (next != null) {
          _handleChatUpdate(next);
        }
      },
      fireImmediately: true,
    );

  }

  Future<void> loadChats() async {
    state = const ChatState.loading();
    try {

      final chats = await _chatRepository.getChats();

      state = ChatState.successLoading(chats: chats);
    } on DioException catch(error) {
      debugPrint('loadChatsError: $error');

      final exception = ErrorHandler.handleDioError(error);
      state = ChatState.successLoading(
        chats: [],
        error: exception.toString()
      );
    } catch (error) {
      debugPrint('loadChatsError: $error');

      final exception = ErrorHandler.handleError(error);
      state = ChatState.successLoading(
          chats: [],
          error: exception.toString()
      );
    }
  }

  void _updateChatInList(DirectChatEntity updatedChat) {
    final currentState = state;
    if (currentState is ChatStateSuccessLoading) {
      final existingChatIndex = currentState.chats.indexWhere(
            (chat) => chat.id == updatedChat.id,
      );

      List<DirectChatEntity> updatedChatsList;

      if (existingChatIndex != -1) {
        debugPrint('🎯 Обновляем существующий чат: ${updatedChat.id}');
        updatedChatsList = List.from(currentState.chats);
        updatedChatsList[existingChatIndex] = updatedChat;
      } else {
        debugPrint('🎯 Добавляем новый чат: ${updatedChat.id}');
        updatedChatsList = [updatedChat, ...currentState.chats];
      }

      updatedChatsList.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

      state = currentState.copyWith(chats: updatedChatsList);
      debugPrint('✅ Список чатов обновлен. Всего: ${updatedChatsList.length}');
    }
  }

  void _handleChatUpdate(Map<String, dynamic> chatData) {
    debugPrint('🎯 WebSocket: Получено обновление чата: $chatData');

    final currentState = state;
    if (currentState is ChatStateSuccessLoading) {
      try {
        if (chatData['chat'] != null) {
          final chatJson = chatData['chat'] as Map<String, dynamic>;

          final updatedChat = DirectChatModel.fromJson(chatJson);
          _updateChatInList(updatedChat.toEntity());

        }
      } catch (e) {
        debugPrint('🔴 Ошибка обработки chatUpdate: $e');
      }
    }
  }
}

final selectedChatProvider = StateProvider<DirectChatEntity?>((ref) => null);

final chatMessagesProvider = StateProvider.family<List<DirectMessageEntity>, String>((ref, chatId) {
  final now = DateTime.now();
  return [
    DirectMessageEntity(
      id: '-1',
      senderId: 'system',
      receiverId: 'current_user',
      text: 'Начало чата',
      createdAt: now.subtract(const Duration(minutes: 30)),
      isRead: true,
      isDelivered: true,
    ),
  ];
});