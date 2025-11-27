import 'package:fakegram/data/dto_s/chat/chat_response/chat_response_dto.dart';
import 'package:fakegram/data/models/direct_message/direct_message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_event_model.freezed.dart';
part 'websocket_event_model.g.dart';

@freezed
abstract class WebSocketEvent with _$WebSocketEvent {
  const factory WebSocketEvent({
    @JsonKey(name: 'type') required String event,
    @JsonKey(name: 'payload') required Map<String, dynamic> data,
  }) = _WebSocketEvent;

  factory WebSocketEvent.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventFromJson(json);
}

@freezed
abstract class ChatListUpdateEvent with _$ChatListUpdateEvent {
  const factory ChatListUpdateEvent({
    required ChatResponseDTO chat,
    required String timestamp,
  }) = _ChatListUpdateEvent;

  factory ChatListUpdateEvent.fromJson(Map<String, dynamic> json) =>
      _$ChatListUpdateEventFromJson(json);
}

@freezed
abstract class NewChatCreatedEvent with _$NewChatCreatedEvent {
  const factory NewChatCreatedEvent({
    required ChatResponseDTO chat,
    required String timestamp,
  }) = _NewChatCreatedEvent;

  factory NewChatCreatedEvent.fromJson(Map<String, dynamic> json) =>
      _$NewChatCreatedEventFromJson(json);
}

@freezed
abstract class MessageSentEvent with _$MessageSentEvent {
  const factory MessageSentEvent({
    required DirectMessageModel message,
  }) = _MessageSentEvent;

  factory MessageSentEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageSentEventFromJson(json);
}

@freezed
abstract class MessageReadEvent with _$MessageReadEvent {
  const factory MessageReadEvent({
    required String userID,
    required String chatID,
    required String readUntilID,
    required String readAt,
  }) = _MessageReadEvent;

  factory MessageReadEvent.fromJson(Map<String, dynamic> json) =>
      _$MessageReadEventFromJson(json);
}

@freezed
abstract class UserTypingEvent with _$UserTypingEvent {
  const factory UserTypingEvent({
    required String userID,
    required String chatID,
    required bool typing,
    required String at,
  }) = _UserTypingEvent;

  factory UserTypingEvent.fromJson(Map<String, dynamic> json) =>
      _$UserTypingEventFromJson(json);
}