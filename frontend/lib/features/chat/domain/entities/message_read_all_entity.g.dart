// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_read_all_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageReadAllEntity _$MessageReadAllEntityFromJson(
        Map<String, dynamic> json) =>
    _MessageReadAllEntity(
      userId: json['user_id'] as String,
      chatId: json['chat_id'] as String,
      readAt: DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$MessageReadAllEntityToJson(
        _MessageReadAllEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'chat_id': instance.chatId,
      'read_at': instance.readAt.toIso8601String(),
    };
