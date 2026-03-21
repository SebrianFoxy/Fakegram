// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_read_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageReadEntity _$MessageReadEntityFromJson(Map<String, dynamic> json) =>
    _MessageReadEntity(
      userId: json['user_id'] as String,
      chatId: json['chat_id'] as String,
      lastReadMessageId: json['last_read_message_id'] as String,
      readAt: DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$MessageReadEntityToJson(_MessageReadEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'chat_id': instance.chatId,
      'last_read_message_id': instance.lastReadMessageId,
      'read_at': instance.readAt.toIso8601String(),
    };
