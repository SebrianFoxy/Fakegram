import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../websocket/domain/entities/websocket_event_entity.dart';
import '../../../../websocket/presentation/notifier/websocket_event_handler.dart';
import '../../../../websocket/presentation/providers/websocket_providers.dart';

class MessageEventHandler implements WebSocketEventHandler {
  static const _messageSent = 'message_sent';
  static const _messageListUpdate = 'message_list_update';
  static const _messageRead = 'message_read';
  static const _messageReadAll = 'message_read_all';

  static const _actionNewMessage = 'new_message';
  static const _actionNewMessageSent = 'new_message_sent';
  static const _actionStatusUpdate = 'message_status_update';
  static const _actionDeleted = 'message_deleted';
  static const _actionDeletedConfirm = 'message_deleted_confirm';
  static const _actionMessageEdited = 'message_edited';

  @override
  bool canHandle(WebSocketEventEntity event) {
    return event.event == _messageSent ||
        event.event == _messageListUpdate ||
        event.event == _messageRead ||
        event.event == _messageReadAll;
  }

  @override
  void handle(WebSocketEventEntity event, Ref ref) {
    switch (event.event) {
      case _messageSent:
        ref.read(newMessageProvider.notifier).update(event.data);
        break;
      case _messageListUpdate:
        _handleMessageListUpdate(event.data, ref);
        break;
      case _messageRead:
        ref.read(messageReadProvider.notifier).update(event.data);
        break;
      case _messageReadAll:
        ref.read(messageReadAllProvider.notifier).update(event.data);
        break;
    }
  }

  void _handleMessageListUpdate(Map<String, dynamic> data, Ref ref) {
    final action = data['action'] as String?;

    switch (action) {
      case _actionMessageEdited:
        ref.read(messageEditedProvider.notifier).update(data);
      case _actionNewMessage:
        ref.read(newMessageFromSocketProvider.notifier).update(data);
      case _actionNewMessageSent:
        ref.read(messageSentConfirmationProvider.notifier).update(data);
      case _actionStatusUpdate:
        ref.read(messageStatusUpdateProvider.notifier).update(data);
      case _actionDeleted:
      case _actionDeletedConfirm:
        ref.read(messageDeletedProvider.notifier).update(data);
    }
  }
}