import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/domain/entities/direct_chat_entity.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/network/error_handling/error_handler.dart';
import '../../../../auth/presentation/providers/user_providers.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';
import '../../../data/models/chat/direct_chat_model.dart';
import 'package:flutter_riverpod/legacy.dart';

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

    ref.listen(
      unreadCountUpdateProvider,
          (previous, next) {
        if (next != null) {
          _handleMessageReadEvent(next);
        }
      },
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

  void _handleMessageReadEvent(Map<String, dynamic> data) {
    try {
      final chatId = data['chat_id'] as String;
      final userId = data['user_id'] as String;
      final unreadCount = data['unread_count'] as int? ?? 0;

      debugPrint('📖 MessageReadWebSocket: чат $chatId, пользователь $userId, непрочитанно $unreadCount');

      final currentState = state;
      if (currentState is! ChatStateSuccessLoading) return;

      final chatIndex = currentState.chats.indexWhere(
            (chat) => chat.id == chatId,
      );

      if (chatIndex == -1) {
        debugPrint('⚠️ Чат $chatId не найден в списке');
        return;
      }

      final chat = currentState.chats[chatIndex];

      final currentUserId = ref.read(currentUserIdProvider);

      if (userId == currentUserId) {
        debugPrint('👤 Текущий пользователь прочитал сообщения в чате $chatId');

        _updateUnreadCount(chat, chatIndex, unreadCount);
      } else {
        debugPrint('👥 Собеседник прочитал наши сообщения в чате $chatId');

        if (chat.lastMessage.senderId == currentUserId) {

          final updatedLastMessage = chat.lastMessage;

          final updatedChat = chat.copyWith(
            lastMessage: updatedLastMessage,
          );

          _updateChatInList(updatedChat);
          debugPrint('✅ Обновлен статус последнего сообщения на "прочитано"');
        }
      }

    } catch (e, stackTrace) {
      debugPrint('❌ Error handling message read event: $e');
      debugPrint(stackTrace.toString());
    }
  }

  void _updateUnreadCount(DirectChatEntity chat, int chatIndex, int newUnreadCount) {
    final currentState = state;
    if (currentState is! ChatStateSuccessLoading) return;

    final updatedChat = chat.copyWith(
      unreadCount: newUnreadCount,
    );

    final updatedChats = List<DirectChatEntity>.from(currentState.chats);
    updatedChats[chatIndex] = updatedChat;

    state = currentState.copyWith(chats: updatedChats);
    debugPrint('📊 Обновлен счетчик непрочитанных для чата ${chat.id}: $newUnreadCount');
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

final chatSelectionStateProvider = Provider<String>((ref) {
  final selectedChat = ref.watch(selectedChatProvider);

  if (selectedChat == null) {
    return "Выберите чат";
  }

  return selectedChat.otherUser.id;
});

final chatMessagesProvider = StateProvider.family<List<MessageEntity>, String>((ref, chatId) {
  return [
    MessageEntity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: '',
      senderId: 'system',
      messageText: 'Начните общение!',
      messageType: 'text',
      replyToMessageId: null,
      isEdited: false,
      isDeleted: false,
      isRead: false,
      createdAt: DateTime.now(),
      readAt: null,
      senderName: '',
      senderSurname: '',
      senderNickname: '',
      senderAvatarUrl: '',
    ),
  ];
});