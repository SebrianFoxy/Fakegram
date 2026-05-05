import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../chat/domain/entities/message_read_entity.dart';

part 'websocket_providers.g.dart';

@riverpod
class ChatUpdate extends _$ChatUpdate {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class NewChat extends _$NewChat {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class NewMessage extends _$NewMessage {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class NewMessageFromSocket extends _$NewMessageFromSocket {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageSentConfirmation extends _$MessageSentConfirmation {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageStatusUpdate extends _$MessageStatusUpdate {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageDeleted extends _$MessageDeleted {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageRead extends _$MessageRead {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageReadAll extends _$MessageReadAll {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class MessageReadStatus extends _$MessageReadStatus {
  @override
  Map<String, DateTime>? build(String chatId) => null;

  void updateReadStatus(MessageReadEntity readEvent) {
    state = {
      ...?state,
      readEvent.lastReadMessageId: readEvent.readAt,
    };
  }
}

@riverpod
class TypingStatus extends _$TypingStatus {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class UserOnlineStatus extends _$UserOnlineStatus {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}

@riverpod
class UnreadCountUpdate extends _$UnreadCountUpdate {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
  }
}
