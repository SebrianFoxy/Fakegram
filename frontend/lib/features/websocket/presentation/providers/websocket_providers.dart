import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../notifier/websocket_notifier.dart';

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
class MessageRead extends _$MessageRead {
  @override
  Map<String, dynamic>? build() => null;

  void update(Map<String, dynamic> data) {
    state = data;
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
