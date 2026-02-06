import 'package:fakegram/features/auth/domain/services/user_service.dart';
import 'package:fakegram/features/auth/presentation/providers/user_providers.dart';
import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/network/error_handling/error_handler.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';
import '../chat/chat_notifier.dart';

part 'message_notifier.freezed.dart';
part 'message_notifier.g.dart';
part 'message_state.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late MessageRepository _messageRepository;
  late UserService _userService;
  int _currentPage = 1;
  final int _messagesPerPage = 20;
  String? _currentChatId;
  String? _currentUserId;
  bool _hasMoreMessages = true;
  bool _isLoadingMore = false;

  @override
  MessageState build() {
    final selectedChat = ref.watch(selectedChatProvider);
    final userId = ref.watch(currentUserIdProvider).value;

    _messageRepository = getIt<MessageRepository>();
    _userService = getIt<UserService>();

    ref.listen<Map<String, dynamic>?>(
      newMessageFromSocketProvider,
          (previous, next) {
        if (next != null) {
          _handleNewMessageFromSocket(next);
        }
      },
    );

    if (userId == null) {
      return const MessageState.loading();
    }

    if (selectedChat != null) {
      _currentChatId = selectedChat.id;
      _currentUserId = userId;
      _resetPagination();
      _loadMessages(
        userId: selectedChat.otherUser.id,
        page: _currentPage,
        limit: _messagesPerPage,
      );
      return const MessageState.loading();
    }

    return state;
  }

  Future<void> _loadMessages({
    required String userId,
    required int page,
    required int limit,
    bool isInitialLoad = false,
  }) async {
    try {
      final messages = await _messageRepository.getMessages(
        userId: userId,
        page: page,
        limit: limit,
      );

      final updatedMessages = messages.messages.map((message) {
        return _updateMessageStatus(message);
      }).toList();

      state = MessageState.successLoading(
        messages: updatedMessages,
        hasMoreMessages: _hasMoreMessages,
        isLoadingMore: false,
      );
    } catch (error) {
      final exception = ErrorHandler.handleError(error);
      state = MessageState.error(error: exception);
    }
  }

  Future<void> loadMoreMessages() async {
    if (!_hasMoreMessages || _isLoadingMore || _currentChatId == null) {
      return;
    }

    _isLoadingMore = true;
    _currentPage++;

    try {
      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat == null) return;

      final newMessages = await _messageRepository.getMessages(
        userId: selectedChat.otherUser.id,
        page: _currentPage,
        limit: _messagesPerPage,
      );

      if (newMessages.hasNext == false) {
        _hasMoreMessages = false;
        final updatedNewMessages = newMessages.messages.map((message) {
          return _updateMessageStatus(message);
        }).toList();

        if (state is MessageStateSuccessLoading) {
          final currentState = state as MessageStateSuccessLoading;
          final allMessages = [...currentState.messages, ...updatedNewMessages];
          state = currentState.copyWith(
            messages: allMessages,
            hasMoreMessages: _hasMoreMessages,
            isLoadingMore: false,
          );
        }
      } else {
        final updatedNewMessages = newMessages.messages.map((message) {
          return _updateMessageStatus(message);
        }).toList();

        if (state is MessageStateSuccessLoading) {
          final currentState = state as MessageStateSuccessLoading;
          final allMessages = [...currentState.messages, ...updatedNewMessages];
          state = currentState.copyWith(
            messages: allMessages,
            hasMoreMessages: _hasMoreMessages,
            isLoadingMore: false,
          );
        }
      }

    } catch (error) {
      _currentPage--;
      final exception = ErrorHandler.handleError(error);
      debugPrint('Error loading more messages: $exception');

      if (state is MessageStateSuccessLoading) {
        final currentState = state as MessageStateSuccessLoading;
        state = currentState.copyWith(
          error: exception.toString(),
          isLoadingMore: false,
        );
      }
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required String messageType,
    String? replyToMessageId,
  }) async {
    try {
      if (_currentChatId == null || _currentUserId == null) {
        return;
      }

      if (messageText.trim().isEmpty) {
        return;
      }

      final userData = await _userService.getCurrentUser();

      final tempId = 'temp_${DateTime.now().millisecondsSinceEpoch}';
      final tempMessage = MessageEntity(
        id: tempId,
        chatId: _currentChatId.toString(),
        senderId: _currentUserId!,
        messageText: messageText,
        messageType: messageType,
        replyToMessageId: replyToMessageId,
        isEdited: false,
        isDeleted: false,
        isRead: false,
        createdAt: DateTime.now().toLocal(),
        readAt: null,
        senderName: userData?.name ?? 'You',
        senderSurname: userData?.surname ?? '',
        senderNickname: userData?.nickname ?? 'you',
        senderAvatarUrl: '',
        status: MessageStatus.sending,
      );

      if (state is MessageStateSuccessLoading) {
        final currentState = state as MessageStateSuccessLoading;
        final updatedMessages = [tempMessage, ...currentState.messages];
        state = currentState.copyWith(messages: updatedMessages);
      }

      final messageData = await _messageRepository.sendMessage(
          chatId: _currentChatId.toString(),
          messageText: messageText,
          messageType: messageType,
          replyToMessageId: replyToMessageId ?? ''
      );

      final serverMessage = MessageEntity(
        id: messageData.id,
        chatId: messageData.chatId,
        senderId: messageData.senderId,
        messageText: messageData.messageText,
        messageType: messageData.messageType,
        replyToMessageId: messageData.replyToMessageId,
        isEdited: messageData.isEdited,
        isDeleted: messageData.isDeleted,
        isRead: messageData.isRead,
        createdAt: messageData.createdAt.toLocal(),
        readAt: messageData.readAt,
        senderName: messageData.senderName,
        senderSurname: messageData.senderSurname,
        senderNickname: messageData.senderNickname,
        senderAvatarUrl: messageData.senderAvatarUrl,
        status: messageData.isRead
            ? MessageStatus.read
            : MessageStatus.sent,
      );

      if (state is MessageStateSuccessLoading) {
        final currentState = state as MessageStateSuccessLoading;
        final updatedMessages = currentState.messages
            .where((m) => m.id != tempId)
            .toList();

        updatedMessages.insert(0, serverMessage);
        state = currentState.copyWith(messages: updatedMessages);
      }
    } catch (error) {
      final exception = ErrorHandler.handleError(error);

      if (kDebugMode) {
        print('❌ Ошибка отправки сообщения: $exception');
      }

      if (state is MessageStateSuccessLoading) {
        final currentState = state as MessageStateSuccessLoading;
        final updatedMessages = currentState.messages.map((message) {
          if (message.id.startsWith('temp_') &&
              message.status == MessageStatus.sending &&
              message.messageText == messageText) {
            return message.copyWith(status: MessageStatus.error);
          }
          return message;
        }).toList();

        state = currentState.copyWith(messages: updatedMessages);

        if (kDebugMode) {
          print('⚠️  Статус временного сообщения изменен на error');
        }
      }
    }
  }

  void _handleNewMessageFromSocket(Map<String, dynamic> data) {
    final action = data['action'] as String?;
    final chatId = data['chat_id'] as String?;

    if (kDebugMode) {
      print('🎯 MessageNotifier: Обработка нового сообщения из WebSocket');
      print('🎯 Chat ID: $chatId, Current Chat ID: $_currentChatId');
      print('🎯 Data: $data');
    }

    if (action == 'new_message' &&
        chatId == _currentChatId &&
        state is MessageStateSuccessLoading) {

      final messageData = data['message'] as Map<String, dynamic>?;
      if (messageData != null) {
        try {
          final newMessage = MessageDetailModel.fromJson(messageData).toEntity();

          final currentState = state as MessageStateSuccessLoading;

          if (!currentState.messages.any((m) => m.id == newMessage.id)) {
            final updatedMessages = [newMessage, ...currentState.messages];

            state = currentState.copyWith(messages: updatedMessages);

            if (kDebugMode) {
              print('✅ Сообщение добавлено в список');
              print('✅ Теперь сообщений: ${updatedMessages.length}');
            }
          }
        } catch (e) {
          debugPrint('Error parsing new message from socket: $e');

          if (kDebugMode) {
            print('❌ Ошибка создания сообщения: $e');
            print('❌ Данные сообщения: $messageData');
          }
        }
      }
    }
  }

  MessageEntity _updateMessageStatus(MessageEntity message) {
    if (message.senderId == _currentUserId) {
      if (message.readAt != null) {
        return message.copyWith(status: MessageStatus.read);
      } else {
        return message.copyWith(status: MessageStatus.sent);
      }
    }
    return message.copyWith(status: MessageStatus.none);
  }

  void _resetPagination() {
    _currentPage = 1;
    _hasMoreMessages = true;
    _isLoadingMore = false;
  }
}