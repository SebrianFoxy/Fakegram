import 'package:fakegram/features/chat/data/models/message/message_detail_model.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/message_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../../core/di/service_locator.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';
import '../chat/chat_notifier.dart';

part 'message_notifier.freezed.dart';
part 'message_notifier.g.dart';
part 'message_state.dart';

@riverpod
class MessageNotifier extends _$MessageNotifier {
  late MessageRepository _messageRepository;
  int _currentPage = 1;
  final int _messagesPerPage = 20;
  String? _currentChatId;

  @override
  MessageState build() {
    _messageRepository = getIt<MessageRepository>();

    final selectedChat = ref.watch(selectedChatProvider);

    ref.listen<Map<String, dynamic>?>(
      newMessageFromSocketProvider,
          (previous, next) {
        if (next != null) {
          _handleNewMessageFromSocket(next);
        }
      },
    );

    if (selectedChat != null) {
      _currentChatId = selectedChat.id;
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
  }) async {
    try {
      final messages = await _messageRepository.getMessages(
        userId: userId,
        page: page,
        limit: limit,
      );
      state = MessageState.successLoading(messages: messages);
    } catch (error) {
      state = MessageState.error(error: error.toString());
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
}