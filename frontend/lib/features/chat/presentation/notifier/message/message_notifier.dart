import 'package:fakegram/features/auth/domain/entities/user_entity.dart';
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

enum LoadDirection {
  initial,
  older,
  newer,
}

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late MessageRepository _messageRepository;
  late UserService _userService;
  static const int _messagesPerPage = 40;
  String? _currentChatId;
  String? _currentUserId;
  bool _isLoadingMore = false;
  bool _isLoadingNewer = false;
  bool _hasUnread = false;
  int _totalUnread = 0;
  int? _firstUnreadIndex;
  final Set<String> _loadedMessageIds = {};
  PaginationMessagesEntity? _lastPaginationEntity;

  @override
  MessageState build() {
    final selectedChat = ref.watch(selectedChatProvider);
    final userId = ref.watch(currentUserIdProvider);

    _initializeDependencies();
    _setupSocketListeners();

    if (userId == null) {
      return const MessageState.loading();
    }

    if (selectedChat != null) {
      _initializeChat(selectedChat, userId);
      return const MessageState.loading();
    }

    return state;
  }

  void _initializeDependencies() {
    _messageRepository = getIt<MessageRepository>();
    _userService = getIt<UserService>();
  }

  void _setupSocketListeners() {
    _listenToSocketEvent(newMessageFromSocketProvider, _handleNewMessageFromSocket);
    _listenToSocketEvent(messageReadProvider, handleMessageReadEvent);
    _listenToSocketEvent(messageReadAllProvider, handleMessageReadAllEvent);
    _listenToSocketEvent(messageDeletedProvider, _handleMessageDeleted);
    _listenToSocketEvent(messageEditedProvider, _handleMessageEdited);
  }

  void _listenToSocketEvent(
      ProviderListenable<Map<String, dynamic>?> provider,
      void Function(Map<String, dynamic>) handler,
      ) {
    ref.listen<Map<String, dynamic>?>(provider, (previous, next) {
      if (next != null) {
        handler(next);
      }
    });
  }

  void _initializeChat(final selectedChat, String userId) {
    _currentChatId = selectedChat.id;
    _currentUserId = userId;
    _resetPagination();
    _loadInitialMessages(userId: selectedChat.otherUser.id);
  }

  Future<void> editMessage({
    required String messageId,
    required String newMessageText,
  }) async {
    if (!_canEditMessage(messageId, newMessageText)) return;

    final currentState = state as MessageStateSuccess;

    final originalMessage = _findMessageById(currentState.messages, messageId);
    if (originalMessage == null) {
      debugPrint('❌ Message $messageId not found');
      return;
    }

    try {
      if (originalMessage.senderId != _currentUserId) {
        debugPrint('❌ Cannot edit message: not owner');
        return;
      }

      final editedMessagePlaceholder = _createEditPlaceholder(originalMessage, newMessageText);

      final updatedMessages = _updateMessageAndReplies(
        currentState.messages,
        messageId,
        editedMessagePlaceholder,
      );

      _updateStateAfterEdit(updatedMessages, messageId);

      final messageData = await _editMessageOnServer(messageId, newMessageText);

      _updateLastMessage(messageData, newMessageText, 'text');
      clearEditMessage();
    } catch (error) {
      _handleEditError(error, messageId, originalMessage);
    }
  }

  Future<void> loadOlderMessages() {
    return _loadMessages(
      userId: _getOtherUserId(),
      direction: LoadDirection.older,
    );
  }

  Future<void> loadNewerMessages() {
    return _loadMessages(
      userId: _getOtherUserId(),
      direction: LoadDirection.newer,
    );
  }

  Future<void> jumpToMessage({
    required String messageId,
    required String messageDate,
  }) async {
    if (_currentChatId == null || _currentUserId == null) return;

    _loadedMessageIds.clear();
    _resetPagination();
    state = const MessageState.loading();

    return _loadMessages(
      userId: _getOtherUserId(),
      direction: LoadDirection.initial,
      cursor: messageDate,
      jumpToMessageId: messageId,
    );
  }

  Future<void> sendMessage({
    required String messageText,
    required String messageType,
    MessageEntity? replyToMessage,
    String? replyToMessageId,
  }) async {
    if (!_canSendMessage(messageText)) return;

    try {
      final userData = await _userService.getCurrentUser();
      final tempMessage = _createTempMessage(
        messageText: messageText,
        messageType: messageType,
        replyToMessage: replyToMessage,
        replyToMessageId: replyToMessageId,
        userData: userData,
      );

      clearReplyingMessage();
      _addTempMessage(tempMessage);

      final messageData = await _sendMessageToServer(
        messageText: messageText,
        messageType: messageType,
        replyToMessageId: replyToMessageId,
      );

      _replaceTempMessage(tempMessage.id, messageData);
      _updateLastMessage(messageData, messageText, messageType);
      _handleReadReceipts();
      _scrollToSentMessage(messageData);

    } catch (error) {
      _handleSendError(error, messageText);
    }
  }

  Future<void> deleteMessage({required String messageId}) async {
    if (!_canDeleteMessage(messageId)) return;

    try {
      final currentState = state as MessageStateSuccess;

      final deletedMessage = _findMessageById(currentState.messages, messageId);
      if (deletedMessage == null) {
        debugPrint('❌ Message $messageId not found');
        return;
      }

      final deletedPlaceholder = _createDeletedPlaceholder(deletedMessage);
      final updatedMessages = _removeMessageAndUpdateReplies(
        currentState.messages,
        messageId,
        deletedPlaceholder,
      );

      _loadedMessageIds.remove(messageId);

      _totalUnread = _calculateNewUnreadCount(
        currentTotal: _totalUnread,
        deletedMessage: deletedMessage,
      );

      _recalculateFirstUnreadIndex(updatedMessages);

      _updateStateAfterDelete(updatedMessages, messageId);
      await _deleteMessageOnServer(messageId);
      _clearReplyingIfTargetDeleted(messageId);

    } catch (error) {
      await _handleDeleteError(error, messageId);
    }
  }

  Future<void> markMessagesAsReadOnView(List<String> messageIds) async {
    if (!_canMarkMessagesAsRead(messageIds)) return;

    final currentState = state as MessageStateSuccess;
    final unreadMessageIds = _getUnreadMessageIds(currentState.messages, messageIds);

    if (unreadMessageIds.isEmpty) return;

    _sendReadReceipts(unreadMessageIds);
    _markMessagesAsRead(unreadMessageIds);
  }

  void handleMessageReadEvent(Map<String, dynamic> data) {
    try {
      final readEntity = MessageReadEntity.fromJson(data);

      if (!_isRelevantReadEvent(readEntity.chatId, readEntity.userId)) return;

      if (kDebugMode) {
        print('📖 Получено подтверждение о прочтении от ${readEntity.userId}');
      }

      if (state is! MessageStateSuccess) return;

      final messageIdsToMark = _getMessageIdsUpToIndex(
        readEntity.lastReadMessageId,
      );

      if (messageIdsToMark.isEmpty) return;

      _markMessagesAsRead(messageIdsToMark, readAt: readEntity.readAt.toLocal());
    } catch (error, stackTrace) {
      debugPrint('handleMessageReadEventError: $error');
    }
  }

  void handleMessageReadAllEvent(Map<String, dynamic> data) {
    try {
      final chatId = data['chat_id'] as String?;
      final userId = data['user_id'] as String?;

      if (!_isRelevantReadEvent(chatId, userId)) return;
      if (kDebugMode) {
        print('📖 Получено подтверждение о прочтении всех сообщений');
      }

      if (state is! MessageStateSuccess) return;

      final messageIdsToMark = _getAllUnreadSenderMessageIds();

      if (messageIdsToMark.isEmpty) return;

      _markMessagesAsRead(messageIdsToMark, readAt: DateTime.now());
    } catch (error, stackTrace) {
      debugPrint('handleMessageReadAllEventError: $error');
    }
  }

  void clearReplyingMessage() {
    state = (state as MessageStateSuccess).copyWith(
      replyingToMessage: null,
    );
  }

  void _clearReplyingIfTargetDeleted(String deletedMessageId) {
    final currentState = state as MessageStateSuccess;

    if (currentState.replyingToMessage?.id == deletedMessageId) {
      clearReplyingMessage();

      if (kDebugMode) {
        print('   🧹 Cleared reply preview for deleted message $deletedMessageId');
      }
    }

    if (currentState.editingMessage?.id == deletedMessageId) {
      clearEditMessage();

      if (kDebugMode) {
        print('   🧹 Cleared edit preview for deleted message $deletedMessageId');
      }
    }
  }

  void setReplyingMessage(MessageEntity message) {
    state = (state as MessageStateSuccess).copyWith(
      replyingToMessage: message,
    );
  }

  Future<void> _loadMessages({
    required String userId,
    required LoadDirection direction,
    String? cursor,
    String? jumpToMessageId,
  }) async {
    if (!_canLoadMore(direction)) return;

    _updateLoadingState(direction, true);

    try {
      final entity = await _fetchMessages(userId, direction, cursor);
      final messages = _processNewMessages(entity.messages, direction);

      _lastPaginationEntity = entity;
      _totalUnread = entity.totalUnread;
      _recalculateFirstUnreadIndex(messages);

      _updateStateAfterLoad(messages, entity, direction, jumpToMessageId);
    } catch (error) {
      _handleError(error);
    } finally {
      _updateLoadingState(direction, false);
    }
  }

  Future<void> _loadInitialMessages({required String userId}) {
    return _loadMessages(
      userId: userId,
      direction: LoadDirection.initial,
    );
  }

  bool _canLoadMore(LoadDirection direction) {
    if (_currentChatId == null) return false;

    return switch (direction) {
      LoadDirection.initial => true,
      LoadDirection.older => (_lastPaginationEntity?.hasMoreOlder ?? true) && !_isLoadingMore,
      LoadDirection.newer => (_lastPaginationEntity?.hasMoreNewer ?? true) && !_isLoadingNewer,
    };
  }

  void _updateLoadingState(LoadDirection direction, bool isLoading) {
    switch (direction) {
      case LoadDirection.older:
        _isLoadingMore = isLoading;
        break;
      case LoadDirection.newer:
        _isLoadingNewer = isLoading;
        break;
      case LoadDirection.initial:
        break;
    }
  }

  Future<PaginationMessagesEntity> _fetchMessages(
      String userId,
      LoadDirection direction,
      String? cursor,
      ) {
    return switch (direction) {
      LoadDirection.initial => _messageRepository.getInitialMessages(
        userId: userId,
        cursor: cursor,
        limit: _messagesPerPage,
      ),
      LoadDirection.older => _messageRepository.getOlderMessages(
        userId: userId,
        cursor: cursor ?? _lastPaginationEntity?.olderCursor ?? _getDefaultCursor(),
        limit: _messagesPerPage,
      ),
      LoadDirection.newer => _messageRepository.getNewerMessages(
        userId: userId,
        cursor: cursor ?? _lastPaginationEntity?.newerCursor ?? _getDefaultCursor(),
        limit: _messagesPerPage,
      ),
    };
  }

  String _getDefaultCursor() {
    return DateTime.now().toUtc().toIso8601String();
  }

  List<MessageEntity> _processNewMessages(
      List<MessageEntity> messages,
      LoadDirection direction,
      ) {
    final newMessages = messages
        .where((m) => !_loadedMessageIds.contains(m.id))
        .map(_updateMessageStatus)
        .toList();

    _loadedMessageIds.addAll(newMessages.map((m) => m.id));

    return _mergeMessages(newMessages, direction);
  }

  List<MessageEntity> _mergeMessages(
      List<MessageEntity> newMessages,
      LoadDirection direction,
      ) {
    if (state is! MessageStateSuccess || direction == LoadDirection.initial) {
      return _sortMessagesByDate(newMessages);
    }

    final currentMessages = (state as MessageStateSuccess).messages;

    final mergedMessages = direction == LoadDirection.older
        ? [...newMessages, ...currentMessages]
        : [...currentMessages, ...newMessages];

    return _sortMessagesByDate(mergedMessages);
  }

  void _updateStateAfterLoad(
      List<MessageEntity> messages,
      PaginationMessagesEntity entity,
      LoadDirection direction,
      String? jumpToMessageId,
      ) {
    switch (direction) {
      case LoadDirection.initial:
        _setInitialState(messages, entity, jumpToMessageId);
        break;
      case LoadDirection.older:
        _updateOlderState(messages, entity);
        break;
      case LoadDirection.newer:
        _updateNewerState(messages, entity);
        break;
    }
  }

  void _setInitialState(
      List<MessageEntity> messages,
      PaginationMessagesEntity entity,
      String? jumpToMessageId,
      ) {
    state = MessageState.success(
      messages: messages,
      hasMoreOlder: entity.hasMoreOlder,
      hasMoreNewer: entity.hasMoreNewer,
      isLoadingMore: false,
      isLoadingNewer: false,
      olderCursor: entity.olderCursor,
      newerCursor: entity.newerCursor,
      totalUnread: entity.totalUnread,
      firstUnreadIndex: _firstUnreadIndex,
      jumpToMessageId: jumpToMessageId,
    );
  }

  void _updateOlderState(
      List<MessageEntity> messages,
      PaginationMessagesEntity entity,
      ) {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      state = currentState.copyWith(
        messages: messages,
        hasMoreOlder: entity.hasMoreOlder,
        olderCursor: entity.olderCursor,
        isLoadingMore: false,
        firstUnreadIndex: _firstUnreadIndex,
      );
    }
  }

  void _updateNewerState(
      List<MessageEntity> messages,
      PaginationMessagesEntity entity,
      ) {
    if (state is MessageStateSuccess) {
      final currentState = state as MessageStateSuccess;

      state = currentState.copyWith(
        messages: messages,
        hasMoreNewer: entity.hasMoreNewer,
        newerCursor: entity.newerCursor,
        isLoadingNewer: false,
        firstUnreadIndex: _firstUnreadIndex,
      );
    }
  }

  String _getOtherUserId() {
    final chat = ref.read(selectedChatProvider);
    if (chat == null) {
      throw StateError('No chat selected');
    }
    return chat.otherUser.id;
  }

  bool _canSendMessage(String messageText) {
    if (_currentChatId == null || _currentUserId == null) {
      debugPrint('❌ Cannot send message: missing chat or user');
      return false;
    }

    if (messageText.trim().isEmpty) {
      debugPrint('❌ Cannot send empty message');
      return false;
    }

    return true;
  }

  MessageEntity _createTempMessage({
    required String messageText,
    required String messageType,
    required UserEntity? userData,
    MessageEntity? replyToMessage,
    String? replyToMessageId,
  }) {
    return MessageEntity(
      id: _generateTempId(),
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
  }

  String _generateTempId() {
    return 'temp_${DateTime.now().millisecondsSinceEpoch}';
  }

  Future<MessageEntity> _sendMessageToServer({
    required String messageText,
    required String messageType,
    String? replyToMessageId,
  }) async {
    return _messageRepository.sendMessage(
      chatId: _currentChatId.toString(),
      messageText: messageText,
      messageType: messageType,
      replyToMessageId: replyToMessageId ?? '',
    );
  }

  void _updateLastMessage(
      MessageEntity messageData,
      String messageText,
      String messageType,
      ) {
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
  }

  void _handleReadReceipts() {
    if (_totalUnread > 0) {
      _sendReadAllReceipts();
    }
  }

  void _scrollToSentMessage(MessageEntity messageData) {
    ref.read(scrollToSentMessageActionProvider.notifier).state = (
    messageId: messageData.id,
    messageDate: messageData.createdAt.toUtc().toIso8601String(),
    );
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
    if (state is! MessageStateSuccess) return;

    final currentState = state as MessageStateSuccess;

    _updateLoadedMessageIds(tempId, messageData.id);

    final serverMessage = _createServerMessage(messageData);
    final updatedMessages = _replaceMessageInList(
      currentState.messages,
      tempId,
      serverMessage,
    );

    state = currentState.copyWith(
      messages: updatedMessages,
    );
  }

  void _updateLoadedMessageIds(String oldId, String newId) {
    _loadedMessageIds.remove(oldId);
    _loadedMessageIds.add(newId);
  }

  MessageEntity _createServerMessage(MessageEntity messageData) {
    return MessageEntity(
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
      replyToMessage: messageData.replyToMessage,
    );
  }

  List<MessageEntity> _replaceMessageInList(
      List<MessageEntity> messages,
      String tempId,
      MessageEntity serverMessage,
      ) {
    final filteredMessages = messages
        .where((m) => m.id != tempId)
        .toList();

    filteredMessages.add(serverMessage);

    return _sortMessagesByDate(filteredMessages);
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

  bool _canDeleteMessage(String messageId) {
    if (_currentChatId == null || _currentUserId == null || messageId.isEmpty) {
      debugPrint('❌ Cannot delete message: missing required data');
      return false;
    }

    if (state is! MessageStateSuccess) {
      debugPrint('❌ Cannot delete message: invalid state');
      return false;
    }

    return true;
  }

  MessageEntity? _findMessageById(List<MessageEntity> messages, String messageId) {
    try {
      return messages.firstWhere((m) => m.id == messageId);
    } catch (_) {
      return null;
    }
  }

  MessageEntity _createDeletedPlaceholder(MessageEntity message) {
    return message.copyWith(
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
  }

  List<MessageEntity> _removeMessageAndUpdateReplies(
      List<MessageEntity> messages,
      String messageId,
      MessageEntity deletedPlaceholder,
      ) {
    return messages
        .map((m) => m.replyToMessageId == messageId
        ? m.copyWith(replyToMessage: deletedPlaceholder)
        : m)
        .where((m) => m.id != messageId)
        .toList();
  }

  int _calculateNewUnreadCount({
    required int currentTotal,
    required MessageEntity deletedMessage,
  }) {
    if (!deletedMessage.isRead && deletedMessage.senderId != _currentUserId) {
      return (currentTotal - 1).clamp(0, currentTotal);
    }
    return currentTotal;
  }

  void _updateStateAfterDelete(List<MessageEntity> updatedMessages, String messageId) {
    state = (state as MessageStateSuccess).copyWith(
      messages: updatedMessages,
      totalUnread: _totalUnread,
      firstUnreadIndex: _firstUnreadIndex,
    );

    if (kDebugMode) {
      final repliesUpdated = updatedMessages
          .where((m) => m.replyToMessageId == messageId)
          .length;
      print('🗑️ Message $messageId removed from UI, $repliesUpdated replies updated');
    }
  }

  Future<void> _deleteMessageOnServer(String messageId) async {
    await _messageRepository.deleteMessage(messageId: messageId);

    if (kDebugMode) {
      print('✅ Message $messageId deleted on server');
    }
  }

  Future<void> _handleDeleteError(dynamic error, String messageId) async {
    debugPrint('❌ DeleteMessageError: ${error.toString()}');
    final exception = ErrorHandler.handleError(error);

    if (state is MessageStateSuccess && _currentChatId != null) {
      await _restoreMessagesAfterError();
      _showTemporaryError(exception.toString());
    } else {
      state = MessageState.error(error: exception);
    }
  }

  Future<void> _restoreMessagesAfterError() async {
    try {
      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat != null) {
        await _loadInitialMessages(userId: selectedChat.otherUser.id);
      }
    } catch (loadError) {
      debugPrint('Failed to restore messages: $loadError');
    }
  }

  void _showTemporaryError(String errorMessage) {
    state = (state as MessageStateSuccess).copyWith(
      error: errorMessage,
    );

    Future.delayed(const Duration(seconds: 3), () {
      if (state is MessageStateSuccess) {
        final updatedState = state as MessageStateSuccess;
        if (updatedState.error == errorMessage) {
          state = updatedState.copyWith(error: null);
        }
      }
    });
  }

  bool _canMarkMessagesAsRead(List<String> messageIds) {
    return messageIds.isNotEmpty &&
        _currentChatId != null &&
        _currentUserId != null &&
        state is MessageStateSuccess;
  }

  List<String> _getUnreadMessageIds(
      List<MessageEntity> messages,
      List<String> messageIds,
      ) {
    final messagesMap = <String, MessageEntity>{
      for (final message in messages) message.id: message
    };

    return messageIds.where((id) {
      final message = messagesMap[id];
      return message != null &&
          !message.isRead &&
          message.senderId != _currentUserId;
    }).toList();
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

  void _markMessagesAsRead(List<String> messageIds, {DateTime? readAt}) {
    if (!_canMarkMessagesAsRead(messageIds)) return;

    final currentState = state as MessageStateSuccess;
    final updatedMessages = _updateMessagesReadStatus(
      currentState.messages,
      messageIds,
      readAt: readAt,
    );

    _updateUnreadCount(updatedMessages);
    _recalculateFirstUnreadIndex(updatedMessages);
    _updateStateWithReadMessages(currentState, updatedMessages);
  }

  List<MessageEntity> _updateMessagesReadStatus(
      List<MessageEntity> messages,
      List<String> messageIds, {
        DateTime? readAt,
      }) {
    return messages.map((message) {
      if (_shouldMarkAsRead(message, messageIds)) {
        return _createReadMessage(message, readAt: readAt);
      }
      return message;
    }).toList();
  }

  bool _shouldMarkAsRead(MessageEntity message, List<String> messageIds) {
    return messageIds.contains(message.id) &&
        (!message.isRead || message.status != MessageStatus.read);
  }

  MessageEntity _createReadMessage(MessageEntity message, {DateTime? readAt}) {
    return message.copyWith(
      isRead: true,
      readAt: readAt ?? DateTime.now(),
      status: MessageStatus.read,
    );
  }

  void _updateUnreadCount(List<MessageEntity> messages) {
    _totalUnread = messages
        .where((m) => !m.isRead && m.senderId != _currentUserId)
        .length;
  }

  void _updateStateWithReadMessages(
      MessageStateSuccess currentState,
      List<MessageEntity> updatedMessages,
      ) {
    state = currentState.copyWith(
      messages: updatedMessages,
      totalUnread: _totalUnread,
      firstUnreadIndex: _firstUnreadIndex,
    );
  }

  bool _isRelevantReadEvent(String? chatId, String? userId) {
    if (chatId != _currentChatId) return false;
    if (userId == _currentUserId) return false;
    return true;
  }

  List<String> _getMessageIdsUpToIndex(String lastReadMessageId) {
    final currentState = state as MessageStateSuccess;

    final lastReadIndex = currentState.messages.indexWhere(
          (m) => m.id == lastReadMessageId,
    );

    if (lastReadIndex == -1) {
      if (kDebugMode) {
        print('⚠️ Сообщение $lastReadMessageId не найдено в списке');
      }
      return [];
    }

    return currentState.messages
        .take(lastReadIndex + 1)
        .where((m) => m.senderId == _currentUserId &&
        (!m.isRead || m.status != MessageStatus.read))
        .map((m) => m.id)
        .toList();
  }

  List<String> _getAllUnreadSenderMessageIds() {
    final currentState = state as MessageStateSuccess;

    return currentState.messages
        .where((m) => m.senderId == _currentUserId && !m.isRead)
        .map((m) => m.id)
        .toList();
  }

  void _handleNewMessageFromSocket(Map<String, dynamic> data) {
    final action = data['action'] as String?;
    final chatId = data['chat_id'] as String?;

    if (kDebugMode) {
      print('🎯 Новое сообщение из WebSocket: $action для чата $chatId');
    }

    if (action != 'new_message' || chatId != _currentChatId) return;
    if (state is! MessageStateSuccess) return;

    final messageData = data['message'] as Map<String, dynamic>?;
    if (messageData == null) return;

    try {
      final newMessage = MessageDetailModel.fromJson(messageData).toEntity();
      final currentState = state as MessageStateSuccess;

      if (_loadedMessageIds.contains(newMessage.id)) {
        debugPrint('⏭️ Сообщение уже загружено, пропускаем: ${newMessage.id}');
        return;
      }

      if (_isTempDuplicate(currentState.messages, newMessage)) {
        debugPrint('⏭️ Найдено временное сообщение-дубликат, пропускаем');
        return;
      }

      debugPrint('✅ Добавляем новое сообщение: ${newMessage.id}');

      _loadedMessageIds.add(newMessage.id);

      final updatedMessage = _updateMessageStatus(newMessage);
      final sortedMessages = _sortMessagesByDate([
        ...currentState.messages,
        updatedMessage,
      ]);

      _updateUnreadCountForNewMessage(updatedMessage);
      _recalculateFirstUnreadIndex(sortedMessages);

      state = currentState.copyWith(
        messages: sortedMessages,
        totalUnread: _totalUnread,
        firstUnreadIndex: _firstUnreadIndex,
      );
    } catch (e) {
      debugPrint('Error parsing new message from socket: $e');
    }
  }

  bool _isTempDuplicate(List<MessageEntity> messages, MessageEntity newMessage) {
    return messages.any((m) =>
    m.id.startsWith('temp_') &&
        m.messageText == newMessage.messageText &&
        m.senderId == newMessage.senderId &&
        (m.createdAt.second == newMessage.createdAt.second ||
            m.createdAt.isAtSameMomentAs(newMessage.createdAt))
    );
  }

  void _updateUnreadCountForNewMessage(MessageEntity message) {
    if (!message.isRead && message.senderId != _currentUserId) {
      _totalUnread++;
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

  void _handleMessageDeleted(Map<String, dynamic> data) {
    try {
      final action = data['action'] as String?;
      final messageId = data['message_id'] as String?;
      final chatId = data['chat_id'] as String?;
      final deletedBy = data['deleted_by'] as String?;

      if (kDebugMode) {
        print('🗑️ Message deleted event: action=$action, messageId=$messageId, chatId=$chatId');
      }

      if (!_canProcessDeleteEvent(chatId, messageId)) return;
      if (state is! MessageStateSuccess) return;

      final targetMessage = _findMessageById(
        (state as MessageStateSuccess).messages,
        messageId!,
      );

      if (targetMessage == null) {
        if (kDebugMode) {
          print('   ⚠️ Message $messageId not found in state');
        }
        return;
      }

      _clearReplyingIfTargetDeleted(messageId);

      switch (action) {
        case 'message_deleted':
          _handleMessageDeletedAction(messageId, targetMessage);
          break;
        case 'message_deleted_confirm':
          if (deletedBy == _currentUserId) {
            _handleMessageDeletedConfirmAction(messageId, targetMessage);
          }
          break;
      }
    } catch (error) {
      debugPrint('handleMessageDeleteEvent: $error');
    }
  }

  bool _canProcessDeleteEvent(String? chatId, String? messageId) {
    return chatId == _currentChatId && messageId != null;
  }

  void _handleMessageDeletedAction(String messageId, MessageEntity targetMessage) {
    final updatedMessages = _performDeleteFromState(messageId, targetMessage);

    _updateTotalUnreadAfterDelete(targetMessage);
    _recalculateFirstUnreadIndex(updatedMessages);
    _updateStateAfterFullDelete(updatedMessages, messageId);
  }

  void _handleMessageDeletedConfirmAction(String messageId, MessageEntity targetMessage) {
    final updatedMessages = _performDeleteFromState(messageId, targetMessage);

    _recalculateFirstUnreadIndex(updatedMessages);
    _updateStateAfterConfirmDelete(updatedMessages, messageId);
  }

  List<MessageEntity> _performDeleteFromState(String messageId, MessageEntity targetMessage) {
    final deletedPlaceholder = _createDeletedPlaceholder(targetMessage);
    final updatedMessages = _removeMessageAndUpdateReplies(
      (state as MessageStateSuccess).messages,
      messageId,
      deletedPlaceholder,
    );

    _loadedMessageIds.remove(messageId);

    return updatedMessages;
  }

  void _updateStateAfterFullDelete(List<MessageEntity> updatedMessages, String messageId) {
    state = (state as MessageStateSuccess).copyWith(
      messages: updatedMessages,
      totalUnread: _totalUnread,
      firstUnreadIndex: _firstUnreadIndex,
    );

    if (kDebugMode) {
      final repliesUpdated = updatedMessages
          .where((m) => m.replyToMessageId == messageId)
          .length;
      print('   ✅ Message $messageId removed, $repliesUpdated replies updated');
    }
  }

  void _updateStateAfterConfirmDelete(List<MessageEntity> updatedMessages, String messageId) {
    state = (state as MessageStateSuccess).copyWith(
      messages: updatedMessages,
      firstUnreadIndex: _firstUnreadIndex,
    );

    if (kDebugMode) {
      print('   ✅ Own deleted message $messageId confirmed');
    }
  }

  void _updateTotalUnreadAfterDelete(MessageEntity deletedMessage) {
    if (!deletedMessage.isRead && deletedMessage.senderId != _currentUserId) {
      _totalUnread = (_totalUnread - 1).clamp(0, _totalUnread);
    }
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

  List<MessageEntity> _updateMessageAndReplies(
      List<MessageEntity> messages,
      String messageId,
      MessageEntity editedMessage,
      ) {
    return messages.map((m) {
      if (m.id == messageId) {
        return editedMessage;
      }

      if (m.replyToMessageId == messageId) {
        return m.copyWith(replyToMessage: editedMessage);
      }

      return m;
    }).toList();
  }

  Future<MessageEntity> _editMessageOnServer(String messageId, String newMessageText) async {
    return await _messageRepository.editMessage(
      messageId: messageId,
      newMessageText: newMessageText,
    );
  }

  Future<void> _handleEditError(Object error, String messageId, MessageEntity oldMessage) async {
    debugPrint('❌ Failed to edit message $messageId: $error');

    try {
      final currentState = state as MessageStateSuccess;

      final restoredMessage = oldMessage.copyWith(
        messageText: oldMessage.messageText,
        status: oldMessage.status,
      );

      final restoredMessages = _updateMessageAndReplies(
        currentState.messages,
        oldMessage.id,
        restoredMessage,
      );

      _updateStateAfterEdit(restoredMessages, oldMessage.id);

      debugPrint('🔄 Message ${oldMessage.id} restored');

    } catch (restoreError) {
      debugPrint('❌ Failed to restore, reloading: $restoreError');
     // await _loadChatMessages();
    }
  }

  void _handleMessageEdited(Map<String, dynamic> data) {
    try {
      final action = data['action'] as String?;
      final messageData = data['message'] as Map<String, dynamic>?;
      final chatId = data['chat_id'] as String?;
      final editedBy = data['edited_by'] as String?;

      if (messageData == null) {
        return;
      }

      final editedMessage = MessageDetailModel.fromJson(messageData).toEntity();
      final currentState = state as MessageStateSuccess;

      if (kDebugMode) {
        print('🗑️ Message edited event: action=$action, messageId=${editedMessage.id}, chatId=$chatId');
      }

      final existingMessage = _findMessageById(currentState.messages, editedMessage.id);
      if (existingMessage == null) {
        if (kDebugMode) {
          print('   ⚠️ Message ${editedMessage.id} not found in state');
        }
        return;
      }

      if (editedBy == _currentUserId) {
        if (kDebugMode) {
          print('   ⏭️ Skipping own edit event');
        }
        return;
      }

      final updatedMessages = _updateMessageAndReplies(
        currentState.messages,
        editedMessage.id,
        editedMessage,
      );

      _updateStateAfterEdit(updatedMessages, editedMessage.id);

      _updateLastMessage(
        editedMessage,
        editedMessage.messageText,
        editedMessage.messageType,
      );

      if (kDebugMode) {
        print('   ✅ Message ${editedMessage.id} updated from socket');
      }
    } catch (error) {
      debugPrint('handleMessageEditEvent: $error');
    }
  }

  void _updateStateAfterEdit(List<MessageEntity> updatedMessages, String messageId) {
    state = (state as MessageStateSuccess).copyWith(messages: updatedMessages);
    debugPrint('✅ Message $messageId updated in state');
  }

  void clearEditMessage() {
    state = (state as MessageStateSuccess).copyWith(
      editingMessage: null,
    );
  }

  void setEditMessage(MessageEntity message) {
    state = (state as MessageStateSuccess).copyWith(
      editingMessage: message,
    );
  }

  MessageEntity _createEditPlaceholder(MessageEntity message, String newMessageText) {
    return message.copyWith(
      isEdited: true,
      messageText: newMessageText,
    );
  }

  bool _canEditMessage(String messageId, String newMessageText) {
    if (_currentChatId == null || _currentUserId == null) {
      debugPrint('❌ Cannot edit message: missing required data');
      return false;
    }

    if (state is! MessageStateSuccess) {
      debugPrint('❌ Cannot edit message: invalid state');
      return false;
    }

    if (newMessageText.trim().isEmpty) {
      debugPrint('❌ Cannot edit message: empty text');
      return false;
    }

    return true;
  }

  void _resetPagination() {
    _isLoadingMore = false;
    _isLoadingNewer = false;
    _totalUnread = 0;
    _hasUnread = false;
    _loadedMessageIds.clear();
    _lastPaginationEntity = null;
  }
}

final messageInputFocusProvider = StateProvider<FocusNode?>((ref) => null);

final scrollToSentMessageActionProvider = StateProvider<({String messageId, String messageDate})?>((ref) => null);