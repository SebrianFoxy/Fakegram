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
      isRead: json['is_read'] as bool? ?? false,
      createdAt: DateTime.parse(json['created_at'] as String),
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      sender: MessageUserDetailModel.fromJson(
          json['sender'] as Map<String, dynamic>),
      replyToMessage: json['reply_to_message'] == null
          ? null
          : MessageDetailModel.fromJson(
              json['reply_to_message'] as Map<String, dynamic>),
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
      'is_read': instance.isRead,
      'created_at': instance.createdAt.toIso8601String(),
      'read_at': instance.readAt?.toIso8601String(),
      'sender': instance.sender,
      'reply_to_message': instance.replyToMessage,
    };
