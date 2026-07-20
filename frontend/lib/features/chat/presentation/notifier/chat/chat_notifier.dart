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
import '../../../domain/entities/last_message_entity.dart';

part 'chat_notifier.freezed.dart';
part 'chat_notifier.g.dart';
part 'chat_state.dart';

@riverpod
class ChatNotifier extends _$ChatNotifier {
  late ChatRepository _chatRepository;

  static const _searchChatLimit = 20;
  int _searchChatOffset = 0;

  List<DirectChatEntity> _cachedChats = [];

  @override
  ChatState build() {
    _initializeDependencies();
    _setupSocketListeners();
    loadChats();
    return const ChatState.initial();
  }

  void _initializeDependencies() {
    _chatRepository = getIt<ChatRepository>();
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

  void _setupSocketListeners() {
    _listenToSocketEvent(chatUpdateProvider, _handleChatUpdate);
    _listenToSocketEvent(chatDeletedProvider, _handleChatDeleted);
    _listenToSocketEvent(unreadCountUpdateProvider, _handleMessageReadEvent);
  }

  void _syncUIWithCache() {
    final currentState = state;

    if (currentState is ChatStateSuccessLoading) {
      final newChats = List<DirectChatEntity>.from(_cachedChats);

      state = ChatState.successLoading(chats: newChats);
    }
  }

  Future<void> loadChats() async {
    state = const ChatState.loading();
    try {
      final chats = await _chatRepository.getChats();

      _cachedChats = List<DirectChatEntity>.from(chats);
      state = ChatState.successLoading(chats: List<DirectChatEntity>.from(chats));
    } on DioException catch (error) {
      _handleLoadError(error);
    } catch (error) {
      _handleLoadError(error);
    }
  }

  Future<void> searchChats(String query) async {
    if (query.trim().length < 3) {
      clearSearch();
      return;
    }

    state = const ChatState.loading();

    try {
      final chats = await _chatRepository.searchChats(
          query: query.trim(),
          offset: _searchChatOffset,
          limit: _searchChatLimit
      );

      state = ChatState.searchChatSuccess(chats: chats);
    } on DioException catch (error) {
      _handleLoadError(error);
    } catch (error) {
      _handleLoadError(error);
    }
  }

  void clearSearch() {
    state = ChatState.successLoading(
      chats: List<DirectChatEntity>.from(_cachedChats),
    );
  }

  void _handleLoadError(dynamic error) {
    debugPrint('loadChatsError: $error');
    final exception = error is DioException
        ? ErrorHandler.handleDioError(error)
        : ErrorHandler.handleError(error);
    state = ChatState.error(error: exception.toString());
  }

  void _handleChatUpdate(Map<String, dynamic> chatData) {
    debugPrint('🎯 WebSocket: Получено обновление чата: $chatData');

    try {
      if (chatData['chat'] != null) {
        final chatJson = chatData['chat'] as Map<String, dynamic>;
        final updatedChat = DirectChatModel.fromJson(chatJson).toEntity();

        _updateCache(updatedChat);
        _syncUIWithCache();
      }
    } catch (e) {
      debugPrint('🔴 Ошибка обработки chatUpdate: $e');
    }
  }

  void _updateCache(DirectChatEntity updatedChat) {
    final index = _findChatIndex(updatedChat.id);

    if (index != -1) {
      _cachedChats[index] = updatedChat;
      debugPrint('🎯 Обновлен существующий чат в кеше: ${updatedChat.id}');
    } else {
      _cachedChats.insert(0, updatedChat);
      debugPrint('🎯 Добавлен новый чат в кеш: ${updatedChat.id}');
    }

    _cachedChats.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
  }

  void _handleMessageReadEvent(Map<String, dynamic> data) {
    try {
      final chatId = data['chat_id'] as String;
      final userId = data['user_id'] as String;
      final unreadCount = data['unread_count'] as int? ?? 0;

      debugPrint('📖 MessageReadWebSocket: чат $chatId, пользователь $userId, непрочитанно $unreadCount');

      final currentUserId = ref.read(currentUserIdProvider);

      final index = _findChatIndex(chatId);
      if (index == -1) return;

      if (userId == currentUserId) {
        _cachedChats[index] = _cachedChats[index].copyWith(unreadCount: unreadCount);
        debugPrint('📊 Обновлен счетчик непрочитанных для чата $chatId: $unreadCount');
        _syncUIWithCache();
      }
    } catch (e, stackTrace) {
      debugPrint('❌ Error handling message read event: $e');
      debugPrint(stackTrace.toString());
    }
  }

  void _handleChatDeleted(Map<String, dynamic> data) {
    try {
      final chatId = data['chat_id'] as String;
      final userId = data['user_id'] as String;

      debugPrint('📖 ChatDeletedWebSocketEvent: чат $chatId, пользователь $userId');

      final index = _findChatIndex(chatId);
      if (index == -1) {
        debugPrint('📖 Чат $chatId не найден в кеше');
        return;
      }

      final selectedChat = ref.read(selectedChatProvider);
      if (selectedChat?.id == chatId) {
        debugPrint('📖 Сбрасываем выбранный чат $chatId');
        ref.read(selectedChatProvider.notifier).state = null;
      }

      final removedChat = _cachedChats.removeAt(index);
      debugPrint('📖 Чат удален: ${removedChat.title}');

      _syncUIWithCache();
    } catch (e, stackTrace) {
      debugPrint('❌ Error handling chat deleted event: $e');
      debugPrint(stackTrace.toString());
    }
  }

  void updateLastMessage({
    required String chatId,
    required LastMessageEntity message,
  }) {
    final selectedChat = ref.read(selectedChatProvider);
    final index = _findChatIndex(chatId);

    if (index == -1) {
      if (selectedChat != null && selectedChat.id == chatId) {
        final newChat = selectedChat.copyWith(
          lastMessage: message,
          updatedAt: message.createdAt
        );

        _cachedChats.insert(0, newChat);
        _cachedChats.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
        _syncUIWithCache();

        debugPrint('📝 Создан новый чат из selectedChat: $chatId');
      } else {
        debugPrint('📝 SelectedChat не совпадает, перезагружаем чаты');
        loadChats();
      }
      return;
    }

    _cachedChats[index] = _cachedChats[index].copyWith(
      lastMessage: message,
      updatedAt: message.createdAt,
    );
    _cachedChats.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    _syncUIWithCache();
    debugPrint('📝 Обновлено последнее сообщение в чате $chatId: ${message.messageText}');
  }

  int _findChatIndex(String chatId) {
    return _cachedChats.indexWhere((c) => c.id == chatId);
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