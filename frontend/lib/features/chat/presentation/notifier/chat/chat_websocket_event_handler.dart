import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../websocket/domain/entities/websocket_event_entity.dart';
import '../../../../websocket/presentation/notifier/websocket_event_handler.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';

class ChatEventHandler implements WebSocketEventHandler {
  static const _chatListUpdate = 'chat_list_update';
  static const _unreadCountUpdate = 'unread_count_update';
  static const _newChatCreated = 'new_chat_created';

  @override
  bool canHandle(WebSocketEventEntity event) {
    return event.event == _chatListUpdate ||
        event.event == _unreadCountUpdate ||
        event.event == _newChatCreated;
  }

  @override
  void handle(WebSocketEventEntity event, Ref ref) {
    switch (event.event) {
      case _chatListUpdate:
        ref.read(chatUpdateProvider.notifier).update(event.data);
        break;
      case _newChatCreated:
        ref.read(newChatProvider.notifier).update(event.data);
        break;
      case _unreadCountUpdate:
        ref.read(unreadCountUpdateProvider.notifier).update(event.data);
        break;
    }
  }
}