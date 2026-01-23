// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageDetailModel _$MessageDetailModelFromJson(Map<String, dynamic> json) =>
    _MessageDetailModel(
      id: json['id'] as String,
      chatId: json['chat_id'] as String,
      senderId: json['sender_id'] as String,
      messageText: json['message_text'] as String,
      messageType: json['message_type'] as String,
      replyToMessageId: json['reply_to_message_id'] as String?,
      isEdited: json['is_edited'] as bool? ?? false,
      isDeleted: json['is_deleted'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      senderName: json['sender_name'] as String,
      senderSurname: json['sender_surname'] as String,
      senderNickname: json['sender_nickname'] as String,
      senderAvatarUrl: json['sender_avatar_url'] as String?,
    );

Map<String, dynamic> _$MessageDetailModelToJson(_MessageDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'sender_id': instance.senderId,
      'message_text': instance.messageText,
      'message_type': instance.messageType,
      'reply_to_message_id': instance.replyToMessageId,
      'is_edited': instance.isEdited,
      'is_deleted': instance.isDeleted,
      'created_at': instance.createdAt.toIso8601String(),
      'read_at': instance.readAt?.toIso8601String(),
      'sender_name': instance.senderName,
      'sender_surname': instance.senderSurname,
      'sender_nickname': instance.senderNickname,
      'sender_avatar_url': instance.senderAvatarUrl,
    };
