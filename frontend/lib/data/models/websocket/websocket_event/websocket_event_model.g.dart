// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebSocketEvent _$WebSocketEventFromJson(Map<String, dynamic> json) =>
    _WebSocketEvent(
      event: json['type'] as String,
      data: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WebSocketEventToJson(_WebSocketEvent instance) =>
    <String, dynamic>{
      'type': instance.event,
      'payload': instance.data,
    };

_ChatListUpdateEvent _$ChatListUpdateEventFromJson(Map<String, dynamic> json) =>
    _ChatListUpdateEvent(
      chat: ChatResponseDTO.fromJson(json['chat'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$ChatListUpdateEventToJson(
        _ChatListUpdateEvent instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'timestamp': instance.timestamp,
    };

_NewChatCreatedEvent _$NewChatCreatedEventFromJson(Map<String, dynamic> json) =>
    _NewChatCreatedEvent(
      chat: ChatResponseDTO.fromJson(json['chat'] as Map<String, dynamic>),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$NewChatCreatedEventToJson(
        _NewChatCreatedEvent instance) =>
    <String, dynamic>{
      'chat': instance.chat,
      'timestamp': instance.timestamp,
    };

_MessageSentEvent _$MessageSentEventFromJson(Map<String, dynamic> json) =>
    _MessageSentEvent(
      message:
          DirectMessageModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageSentEventToJson(_MessageSentEvent instance) =>
    <String, dynamic>{
      'message': instance.message,
    };

_MessageReadEvent _$MessageReadEventFromJson(Map<String, dynamic> json) =>
    _MessageReadEvent(
      userID: json['userID'] as String,
      chatID: json['chatID'] as String,
      readUntilID: json['readUntilID'] as String,
      readAt: json['readAt'] as String,
    );

Map<String, dynamic> _$MessageReadEventToJson(_MessageReadEvent instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'chatID': instance.chatID,
      'readUntilID': instance.readUntilID,
      'readAt': instance.readAt,
    };

_UserTypingEvent _$UserTypingEventFromJson(Map<String, dynamic> json) =>
    _UserTypingEvent(
      userID: json['userID'] as String,
      chatID: json['chatID'] as String,
      typing: json['typing'] as bool,
      at: json['at'] as String,
    );

Map<String, dynamic> _$UserTypingEventToJson(_UserTypingEvent instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'chatID': instance.chatID,
      'typing': instance.typing,
      'at': instance.at,
    };
