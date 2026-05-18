import 'package:fakegram/features/auth/domain/services/user_service.dart';
import 'package:fakegram/features/auth/presentation/providers/user_providers.dart';
import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/message_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../../core/network/error_handling/error_handler.dart';
import '../../../../websocket/presentation/notifier/websocket_notifier.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';
import '../../../domain/entities/last_message_entity.dart';
import '../../../domain/entities/message_read_entity.dart';
import '../../../domain/entities/pagination_messages_entity.dart';
import '../chat/chat_notifier.dart';

part 'message_notifier.freezed.dart';
part 'message_notifier.g.dart';
part 'message_state.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late MessageRepository _messageRepository;
  late UserService _userService;
  final int _messagesPerPage = 40;
  String? _currentChatId;
  String? _currentUserId;
  String? _olderCursor;
  String? _newerCursor;
  bool _hasMoreOlder = true;
  bool _hasMoreNewer = true;
  bool _isLoadingMore = false;
  bool _isLoadingNewer = false;
  bool _hasUnread = false;
  int _totalUnread = 0;
  int? _firstUnreadIndex;
  final Set<String> _loadedMessageIds = {};

  @override
  MessageState build() {
    final selectedChat = ref.watch(selectedChatProvider);
    final userId = ref.watch(currentUserIdProvider);

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

    ref.listen<Map<String, dynamic>?>(
      messageReadProvider,
          (previous, next) {
        if (next != null) {
          handleMessageReadEvent(next);
        }
      },
    );

    ref.listen<Map<String, dynamic>?>(
      messageReadAllProvider,
          (previous, next) {
        if (next != null) {
          handleMessageReadAllEvent(next);
        }
      },
    );

    ref.listen<Map<String, dynamic>?>(
      messageDeletedProvider,
          (previous, next) {
        if (next != null) {
          _handleMessageDeleted(next);
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
      _loadInitialMessages(userId: selectedChat.otherUser.id);
      return const MessageState.loading();
    }

    return state;
  }

  Future<void> _loadInitialMessages({required String userId}) async {
    try {
      final result = await _messageRepository.getInitialMessages(
        userId: userId,
        limit: _messagesPerPage,
      );

      _updatePaginationState(result);
      _totalUnread = result.totalUnread;

      final sortedMessages = _sortMessagesByDate(result.messages);

      _loadedMessageIds.clear();
      _loadedMessageIds.addAll(sortedMessages.map((m) => m.id));

      if (sortedMessages.isNotEmpty) {
        final firstUnreadIndex = sortedMessages.indexWhere(
              (m) => !m.isRead && m.senderId != _currentUserId,
        );

        if (firstUnreadIndex != -1) {
          _firstUnreadIndex = firstUnreadIndex;
          _hasUnread = true;
        } else {
          _firstUnreadIndex = null;
          _hasUnread = false;
        }
      }

      final updatedMessages = sortedMessages.map((message) {
        return _updateMessageStatus(message);
      }).toList();

      state = MessageState.success(
        messages: updatedMessages,
        hasMoreOlder: result.hasMoreOlder,
        hasMoreNewer: result.hasMoreNewer,
        isLoadingMore: false,
        isLoadingNewer: false,
        olderCursor: result.olderCursor,
        newerCursor: result.newerCursor,
        totalUnread: result.totalUnread,
        firstUnreadIndex: _firstUnreadIndex,
      );
    } catch (error) {
      debugPrint('LoadMessageInitialError: ${error.toString()}');
      final exception = ErrorHandler.handleError(error);
      state = MessageState.error(error: exception);
    }
  }

  Future<void> loadOlderMessages() async {
    if (!_hasMoreOlder || _isLoadingMore || _currentChatId == null) {
      return;
    }

    _isLoadingMore = true;
    _updateLoadingState();

    try {
      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat == null) return;

      final result = await _messageRepository.getOlderMessages(
        userId: selectedChat.otherUser.id,
        cursor: _olderCursor ?? DateTime.now().toUtc().toIso8601String(),
        limit: _messagesPerPage,
      );

      _updatePaginationState(result);

      final newMessages = result.messages
          .where((m) => !_loadedMessageIds.contains(m.id))
          .toList();

      _loadedMessageIds.addAll(newMessages.map((m) => m.id));

      final updatedNewMessages = newMessages.map((message) {
        return _updateMessageStatus(message);
      }).toList();

      if (state is MessageStateSuccess) {
        final currentState = state as MessageStateSuccess;

        final allMessages = [...updatedNewMessages, ...currentState.messages];
        final sortedMessages = _sortMessagesByDate(allMessages);

        _recalculateFirstUnreadIndex(sortedMessages);

        state = currentState.copyWith(
          messages: sortedMessages,
          hasMoreOlder: result.hasMoreOlder,
          olderCursor: result.olderCursor,
          isLoadingMore: false,
          firstUnreadIndex: _firstUnreadIndex,
        );
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _isLoadingMore = false;
    }
  }

  Future<void> loadNewerMessages() async {
    if (!_hasMoreNewer || _isLoadingNewer || _currentChatId == null) {
      return;
    }

    _isLoadingNewer = true;
    _updateLoadingState();

    try {
      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat == null) return;

      final result = await _messageRepository.getNewerMessages(
        userId: selectedChat.otherUser.id,
        cursor: _newerCursor ?? DateTime.now().toIso8601String(),
        limit: _messagesPerPage,
      );

      _updatePaginationState(result);

      final newMessages = result.messages
          .where((m) => !_loadedMessageIds.contains(m.id))
          .toList();

      _loadedMessageIds.addAll(newMessages.map((m) => m.id));

      final updatedNewMessages = newMessages.map((message) {
        return _updateMessageStatus(message);
      }).toList();

      if (state is MessageStateSuccess) {
        final currentState = state as MessageStateSuccess;

        final allMessages = [...currentState.messages, ...updatedNewMessages];
        final sortedMessages = _sortMessagesByDate(allMessages);

        _recalculateFirstUnreadIndex(sortedMessages);

        state = currentState.copyWith(
          messages: sortedMessages,
          hasMoreNewer: result.hasMoreNewer,
          newerCursor: result.newerCursor,
          isLoadingNewer: false,
          firstUnreadIndex: _firstUnreadIndex,
        );
      }
    } catch (error) {
      _handleError(error);
    } finally {
      _isLoadingNewer = false;
    }
  }

  Future<void> jumpToMessage({
    required String messageId,
    required String messageDate,
  }) async {
    try {
      if (_currentChatId == null || _currentUserId == null) {
        return;
      }

      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat == null) return;

      _loadedMessageIds.clear();
      _resetPagination();

      state = const MessageState.loading();

      final result = await _messageRepository.getInitialMessages(
        userId: selectedChat.otherUser.id,
        cursor: messageDate,
        limit: _messagesPerPage,
      );

      _updatePaginationState(result);
      _totalUnread = result.totalUnread;

      final sortedMessages = _sortMessagesByDate(result.messages);

      _loadedMessageIds.addAll(sortedMessages.map((m) => m.id));

      final updatedMessages = sortedMessages.map((message) {
        return _updateMessageStatus(message);
      }).toList();

      _recalculateFirstUnreadIndex(updatedMessages);

      state = MessageState.success(
        messages: updatedMessages,
        hasMoreOlder: result.hasMoreOlder,
        hasMoreNewer: result.hasMoreNewer,
        isLoadingMore: false,
        isLoadingNewer: false,
        olderCursor: result.olderCursor,
        newerCursor: result.newerCursor,
        totalUnread: result.totalUnread,
        firstUnreadIndex: _firstUnreadIndex,
        jumpToMessageId: messageId,
      );
    } catch (error) {
      debugPrint('JumpToMessageError: ${error.toString()}');
      final exception = ErrorHandler.handleError(error);
      state = MessageState.error(error: exception);
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required String messageType,
    MessageEntity? replyToMessage,
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
        isRead: true,
        createdAt: DateTime.now().toLocal(),
        readAt: DateTime.now(),
        senderName: userData?.name ?? 'You',
        senderSurname: userData?.surname ?? '',
        senderNickname: userData?.nickname ?? 'you',
        senderAvatarUrl: '',
        status: MessageStatus.sending,
        replyToMessage: replyToMessage,
      );

      clearReplyingMessage();
      _addTempMessage(tempMessage);

      final messageData = await _messageRepository.sendMessage(
        chatId: _currentChatId.toString(),
        messageText: messageText,
        messageType: messageType,
        replyToMessageId: replyToMessageId ?? '',
      );

      _replaceTempMessage(tempId, messageData);

      final lastMessageEntity = LastMessageEntity(
        id: messageData.id,
        chatId: _currentChatId!,
        senderId: _currentUserId!,
        messageText: messageText,
        messageType: messageType,
        isEdited: false,
        isDeleted: false,
        createdAt: messageData.createdAt,
      );

      ref.read(chatProvider.notifier).updateLastMessage(
        chatId: _currentChatId!,
        message: lastMessageEntity,
      );

      if (_totalUnread > 0) {
        _sendReadAllReceipts();
      }

      ref.read(scrollToSentMessageActionProvider.notifier).state = (
        messageId: messageData.id,
        messageDate: messageData.createdAt.toUtc().toIso8601String(),
      );

    } catch (error) {
      _handleSendError(error, messageText);
    }
  }

  Future<void> deleteMessage({required String messageId}) async {
    try {
      if (_currentChatId == null || _currentUserId == null || messageId.isEmpty) {
        debugPrint('❌ Cannot delete message: missing required data');
        return;
      }

      if (state is! MessageStateSuccess) return;
      final currentState = state as MessageStateSuccess;

      final deletedMessage = currentState.messages.firstWhere(
            (m) => m.id == messageId,
        orElse: () => MessageEntity(
          id: '',
          chatId: '',
          senderId: '',
          messageText: '',
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
          status: MessageStatus.sent,
          replyToMessage: null,
        ),
      );

      if (deletedMessage.id.isEmpty) {
        debugPrint('❌ Message $messageId not found');
        return;
      }

      final deletedReplyPlaceholder = deletedMessage.copyWith(
        isDeleted: true,
        messageText: '',
        messageType: 'deleted',
        senderName: '',
        senderSurname: '',
        senderNickname: '',
        senderAvatarUrl: '',
        replyToMessage: null,
        replyToMessageId: null,
      );

      final updatedMessages = currentState.messages.map((m) {
        if (m.replyToMessageId == messageId) {
          return m.copyWith(
            replyToMessage: deletedReplyPlaceholder,
          );
        }
        return m;
      }).where((m) => m.id != messageId).toList();

      _loadedMessageIds.remove(messageId);

      if (!deletedMessage.isRead && deletedMessage.senderId != _currentUserId) {
        _totalUnread = (_totalUnread - 1).clamp(0, _totalUnread);
      }

      _recalculateFirstUnreadIndex(updatedMessages);

      state = currentState.copyWith(
        messages: updatedMessages,
        totalUnread: _totalUnread,
        firstUnreadIndex: _firstUnreadIndex,
      );

      if (kDebugMode) {
        print('🗑️ Message $messageId removed from UI, ${updatedMessages.where((m) => m.replyToMessageId == messageId).length} replies updated');
      }

      await _messageRepository.deleteMessage(messageId: messageId);

      if (kDebugMode) {
        print('✅ Message $messageId deleted on server');
      }

    } catch (error) {
      debugPrint('❌ DeleteMessageError: ${error.toString()}');
      final exception = ErrorHandler.handleError(error);

      if (state is MessageStateSuccess && _currentChatId != null) {
        try {
          final selectedChat = ref.read(selectedChatProvider);
          if (selectedChat != null) {
            await _loadInitialMessages(userId: selectedChat.otherUser.id);
          }
        } catch (loadError) {
          debugPrint('Failed to restore messages: $loadError');
        }

        state = (state as MessageStateSuccess).copyWith(
          error: exception.toString(),
        );

        Future.delayed(const Duration(seconds: 3), () {
          if (state is MessageStateSuccess) {
            final updatedState = state as MessageStateSuccess;
            if (updatedState.error == exception.toString()) {
              state = updatedState.copyWith(error: null);
            }
          }
        });
      } else {
        state = MessageState.error(error: exception);
      }
    }
  }

  Future<void> markMessagesAsReadOnView(List<String> messageIds) async {
    if (messageIds.isEmpty || _currentChatId == null || _currentUserId == null) {
      return;
    }

    if (state is! MessageStateSuccess) return;
    final currentState = state as MessageStateSuccess;

    final messagesMap = <String, MessageEntity>{};
    for (final message in currentState.messages) {
      messagesMap[message.id] = message;
    }

    final unreadMessageIds = <String>[];

    for (final id in messageIds) {
      final message = messagesMap[id];
      if (message != null &&
          !message.isRead &&
          message.senderId != _currentUserId) {
        unreadMessageIds.add(id);
      }
    }

    if (unreadMessageIds.isEmpty) return;

    _sendReadReceipts(unreadMessageIds);
    _markMessagesAsRead(unreadMessageIds);
  }

  List<MessageEntity> _sortMessagesByDate(List<MessageEntity> messages) {
    final sorted = List<MessageEntity>.from(messages);
    sorted.sort((a, b) {
      final comparison = a.createdAt.compareTo(b.createdAt);

      if (comparison == 0) {
        return a.id.compareTo(b.id);
      }
      return comparison;
    });
    return sorted;
  }

  MessageEntity _updateMessageStatus(MessageEntity message) {
    if (message.senderId == _currentUserId) {
      return message.copyWith(
        isRead: true,
        status: (message.readAt != null && message.isRead) ? MessageStatus.read : MessageStatus.sent,
      );
    }

    return message.copyWith(
      isRead: message.isRead,
      status: message.isRead ? MessageStatus.read : MessageStatus.sending,
    );
  }

  void _recalculateFirstUnreadIndex(List<MessageEntity> messages) {
    final firstUnreadIndex = messages.indexWhere(
          (m) => !m.isRead && m.senderId != _currentUserId,
    );

    if (firstUnreadIndex != -1) {
      _firstUnreadIndex = firstUnreadIndex;
      _hasUnread = true;
    } else {
      _firstUnreadIndex = null;
      _hasUnread = false;
    }
  }

  void updateFirstUnreadIndex(int newIndex) {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;
      state = currentState.copyWith(firstUnreadIndex: newIndex);
    }
  }

  void _addTempMessage(MessageEntity tempMessage) {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      _loadedMessageIds.add(tempMessage.id);

      final allMessages = [...currentState.messages, tempMessage];
      final sortedMessages = _sortMessagesByDate(allMessages);

      state = currentState.copyWith(
        messages: sortedMessages,
      );
    }
  }

  void _replaceTempMessage(String tempId, MessageEntity messageData) {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      _loadedMessageIds.remove(tempId);
      _loadedMessageIds.add(messageData.id);

      final serverMessage = MessageEntity(
        id: messageData.id,
        chatId: messageData.chatId,
        senderId: messageData.senderId,
        messageText: messageData.messageText,
        messageType: messageData.messageType,
        replyToMessageId: messageData.replyToMessageId,
        isEdited: messageData.isEdited,
        isDeleted: messageData.isDeleted,
        isRead: true,
        createdAt: messageData.createdAt.toLocal(),
        readAt: messageData.createdAt.toLocal(),
        senderName: messageData.senderName,
        senderSurname: messageData.senderSurname,
        senderNickname: messageData.senderNickname,
        senderAvatarUrl: '',
        status: MessageStatus.sent,
        replyToMessage: messageData.replyToMessage
      );

      final filteredMessages = currentState.messages
          .where((m) => m.id != tempId)
          .toList();

      filteredMessages.add(serverMessage);

      final sortedMessages = _sortMessagesByDate(filteredMessages);

      state = currentState.copyWith(
        messages: sortedMessages,
      );
    }
  }

  void _handleSendError(Object error, String messageText) {
    final exception = ErrorHandler.handleError(error);
    debugPrint('❌ Ошибка отправки сообщения: $exception');

    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      final updatedMessages = currentState.messages.map((message) {
        if (message.id.startsWith('temp_') &&
            message.status == MessageStatus.sending &&
            message.messageText == messageText) {
          return message.copyWith(status: MessageStatus.error);
        }
        return message;
      }).toList();

      state = currentState.copyWith(messages: updatedMessages);
    }
  }

  void _handleNewMessageFromSocket(Map<String, dynamic> data) {
    final action = data['action'] as String?;
    final chatId = data['chat_id'] as String?;

    if (kDebugMode) {
      print('🎯 Новое сообщение из WebSocket: $action для чата $chatId');
    }

    if (action == 'new_message' && chatId == _currentChatId) {
      final messageData = data['message'] as Map<String, dynamic>?;
      if (messageData != null) {
        try {
          final newMessage = MessageDetailModel.fromJson(messageData).toEntity();

          if (state is MessageStateSuccess) {
            final currentState = state as MessageStateSuccess;

            if (_loadedMessageIds.contains(newMessage.id)) {
              debugPrint('⏭️ Сообщение уже загружено, пропускаем: ${newMessage.id}');
              return;
            }

            final hasTempDuplicate = currentState.messages.any((m) =>
            m.id.startsWith('temp_') &&
                m.messageText == newMessage.messageText &&
                m.senderId == newMessage.senderId &&
                (m.createdAt.second == newMessage.createdAt.second ||
                    m.createdAt.isAtSameMomentAs(newMessage.createdAt))
            );

            if (hasTempDuplicate) {
              debugPrint('⏭️ Найдено временное сообщение-дубликат, пропускаем');
              return;
            }

            debugPrint('✅ Добавляем новое сообщение: ${newMessage.id}');

            _loadedMessageIds.add(newMessage.id);

            final updatedMessage = _updateMessageStatus(newMessage);

            final allMessages = [...currentState.messages, updatedMessage];
            final sortedMessages = _sortMessagesByDate(allMessages);

            if (!updatedMessage.isRead && updatedMessage.senderId != _currentUserId) {
              _totalUnread++;
            }

            _recalculateFirstUnreadIndex(sortedMessages);

            state = currentState.copyWith(
              messages: sortedMessages,
              totalUnread: _totalUnread,
              firstUnreadIndex: _firstUnreadIndex,
            );
          }
        } catch (e) {
          debugPrint('Error parsing new message from socket: $e');
        }
      }
    }
  }

  void _sendReadReceipts(List<String> messageIds) {
    if (messageIds.isEmpty || _currentChatId == null) return;

    final webSocketNotifier = ref.read(webSocketProvider.notifier);

    final lastMessageId = messageIds.last;
    webSocketNotifier.sendMessageRead(_currentChatId!, lastMessageId);

    if (kDebugMode) {
      print('📤 Отправлено подтверждение о прочтении для сообщения: $lastMessageId');
    }
  }

  void _sendReadAllReceipts() {
    if (_currentChatId == null) return;

    final webSocketNotifier = ref.read(webSocketProvider.notifier);

    webSocketNotifier.sendMessageAllRead(_currentChatId!);

    if (kDebugMode) {
      print('📤 Отправлено подтверждение о прочтении всех сообщение после sendMessage');
    }
  }

  void _markMessagesAsRead(List<String> messageIds) {
    if (messageIds.isEmpty || _currentChatId == null) return;

    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      final updatedMessages = currentState.messages.map((message) {
        if (messageIds.contains(message.id) && !message.isRead) {
          return message.copyWith(
            isRead: true,
            readAt: DateTime.now(),
            status: MessageStatus.read,
          );
        }
        return message;
      }).toList();

      _totalUnread = updatedMessages
          .where((m) => !m.isRead && m.senderId != _currentUserId)
          .length;

      _recalculateFirstUnreadIndex(updatedMessages);

      state = currentState.copyWith(
        messages: updatedMessages,
        totalUnread: _totalUnread,
        firstUnreadIndex: _firstUnreadIndex,
      );
    }
  }

  void handleMessageReadEvent(Map<String, dynamic> data) {
    try {
      final readEntity = MessageReadEntity.fromJson(data);

      if (readEntity.chatId != _currentChatId) return;

      if (kDebugMode) {
        print('📖 Получено подтверждение о прочтении от ${readEntity.userId}');
      }

      if (state is! MessageStateSuccess) return;

      final currentState = state as MessageStateSuccess;

      final lastReadMessageIndex = currentState.messages.indexWhere(
              (m) => m.id == readEntity.lastReadMessageId
      );

      if (lastReadMessageIndex == -1) return;

      final updatedMessages = currentState.messages.asMap().entries.map((entry) {
        final index = entry.key;
        final message = entry.value;

        if (message.senderId == _currentUserId && index <= lastReadMessageIndex) {
          if (!message.isRead || message.status != MessageStatus.read) {
            if (kDebugMode) {
              print('   ✅ Отмечаем как прочитанное: ${message.id} (${message.messageText})');
            }
            return message.copyWith(
              isRead: true,
              readAt: readEntity.readAt.toLocal(),
              status: MessageStatus.read,
            );
          }
        }
        return message;
      }).toList();

      state = currentState.copyWith(messages: updatedMessages);
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error handling message_read event: $e');
        print(stackTrace);
      }
    }
  }

  void handleMessageReadAllEvent(Map<String, dynamic> data) {
    try {
      final chatId = data['chat_id'] as String?;
      final userId = data['user_id'] as String?;

      if (chatId != _currentChatId) return;
      if (userId == _currentUserId) return;

      if (kDebugMode) {
        print('📖 Все сообщения в чате прочитаны пользователем $userId');
      }

      if (state is! MessageStateSuccess) return;
      final currentState = state as MessageStateSuccess;

      final now = DateTime.now();
      final updatedMessages = currentState.messages.map((message) {
        if (message.senderId == _currentUserId && message.status != MessageStatus.read) {
          if (kDebugMode) {
            print('   ✅ Отмечаем как прочитанное: ${message.id} (${message.messageText})');
          }
          return message.copyWith(
            isRead: true,
            readAt: now,
            status: MessageStatus.read,
          );
        }
        return message;
      }).toList();

      _recalculateFirstUnreadIndex(updatedMessages);

      state = currentState.copyWith(
        messages: updatedMessages,
        firstUnreadIndex: _firstUnreadIndex,
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error in handleMessageReadAllEvent: $e');
        print(stackTrace);
      }
    }
  }

  void _handleError(Object error) {
    final exception = ErrorHandler.handleError(error);
    debugPrint('Error: $exception');

    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;
      state = currentState.copyWith(
        error: exception.toString(),
        isLoadingMore: false,
        isLoadingNewer: false,
      );
    }
  }

  void _updatePaginationState(PaginationMessagesEntity result) {
    _olderCursor = result.olderCursor;
    _newerCursor = result.newerCursor;
    _hasMoreOlder = result.hasMoreOlder;
    _hasMoreNewer = result.hasMoreNewer;
  }

  void _updateLoadingState() {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;
      state = currentState.copyWith(
        isLoadingMore: _isLoadingMore,
        isLoadingNewer: _isLoadingNewer,
      );
    }
  }

  void setReplyingMessage(MessageEntity message) {
    state = (state as MessageStateSuccess).copyWith(
      replyingToMessage: message,
    );
  }

  void _handleMessageDeleted(Map<String, dynamic> data) {
    try {
      final action = data['action'] as String?;
      final messageId = data['message_id'] as String?;
      final chatId = data['chat_id'] as String?;
      final deletedBy = data['deleted_by'] as String?;

      if (kDebugMode) {
        print('🗑️ Message deleted event: action=$action, messageId=$messageId, chatId=$chatId');
      }

      if (chatId != _currentChatId || messageId == null) {
        return;
      }

      if (state is! MessageStateSuccess) return;
      final currentState = state as MessageStateSuccess;

      final targetMessage = currentState.messages.firstWhere(
            (m) => m.id == messageId,
        orElse: () => MessageEntity(
          id: '',
          chatId: '',
          senderId: '',
          messageText: '',
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
          status: MessageStatus.sent,
          replyToMessage: null,
        ),
      );

      if (targetMessage.id.isEmpty) {
        if (kDebugMode) {
          print('   ⚠️ Message $messageId not found in state');
        }
        return;
      }

      switch (action) {
        case 'message_deleted':
          final deletedReplyPlaceholder = targetMessage.copyWith(
            isDeleted: true,
            messageText: '',
            messageType: 'deleted',
            senderName: '',
            senderSurname: '',
            senderNickname: '',
            senderAvatarUrl: '',
            replyToMessage: null,
            replyToMessageId: null,
          );

          final updatedMessages = currentState.messages.map((m) {
            if (m.replyToMessageId == messageId) {
              return m.copyWith(
                replyToMessage: deletedReplyPlaceholder,
              );
            }
            return m;
          }).where((m) => m.id != messageId).toList();

          _loadedMessageIds.remove(messageId);

          final wasUnread = !targetMessage.isRead && targetMessage.senderId != _currentUserId;

          if (wasUnread) {
            _totalUnread = (_totalUnread - 1).clamp(0, _totalUnread);
          }

          _recalculateFirstUnreadIndex(updatedMessages);

          state = currentState.copyWith(
            messages: updatedMessages,
            totalUnread: _totalUnread,
            firstUnreadIndex: _firstUnreadIndex,
          );

          if (kDebugMode) {
            print('   ✅ Message $messageId removed, ${updatedMessages.where((m) => m.replyToMessageId == messageId).length} replies updated');
          }
          break;

        case 'message_deleted_confirm':
          if (deletedBy == _currentUserId) {
            final deletedReplyPlaceholder = targetMessage.copyWith(
              isDeleted: true,
              messageText: '',
              messageType: 'deleted',
              senderName: '',
              senderSurname: '',
              senderNickname: '',
              senderAvatarUrl: '',
              replyToMessage: null,
              replyToMessageId: null,
            );

            final updatedMessages = currentState.messages.map((m) {
              if (m.replyToMessageId == messageId) {
                return m.copyWith(
                  replyToMessage: deletedReplyPlaceholder,
                );
              }
              return m;
            }).where((m) => m.id != messageId).toList();

            _loadedMessageIds.remove(messageId);

            _recalculateFirstUnreadIndex(updatedMessages);

            state = currentState.copyWith(
              messages: updatedMessages,
              firstUnreadIndex: _firstUnreadIndex,
            );

            if (kDebugMode) {
              print('   ✅ Own deleted message $messageId confirmed');
            }
          }
          break;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error handling message deleted event: $e');
        print(stackTrace);
      }
    }
  }

  void clearReplyingMessage() {
    state = (state as MessageStateSuccess).copyWith(
      replyingToMessage: null,
    );
  }

  void _resetPagination() {
    _olderCursor = null;
    _newerCursor = null;
    _hasMoreOlder = true;
    _hasMoreNewer = true;
    _isLoadingMore = false;
    _isLoadingNewer = false;
    _totalUnread = 0;
    _hasUnread = false;
    _loadedMessageIds.clear();
  }
}

final messageInputFocusProvider = StateProvider<FocusNode?>((ref) => null);

final scrollToSentMessageActionProvider = StateProvider<({String messageId, String messageDate})?>((ref) => null);
