// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    _LastMessageModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      messageText: json['message_text'] as String,
      messageType: json['message_type'] as String,
      isEdited: json['is_edited'] as bool,
      isDeleted: json['is_deleted'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$LastMessageModelToJson(_LastMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'sender_id': instance.senderId,
      'message_text': instance.messageText,
      'message_type': instance.messageType,
      'is_edited': instance.isEdited,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
    };
