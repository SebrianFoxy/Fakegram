// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageRequestDTO _$MessageRequestDTOFromJson(Map<String, dynamic> json) =>
    _MessageRequestDTO(
      chatId: json['chat_id'] as String,
      message: json['message_text'] as String,
      messageType: json['message_type'] as String,
      receiverId: json['receiver_id'] as String?,
      replyToMessageId: json['reply_to_message_id'] as String? ?? '',
    );

Map<String, dynamic> _$MessageRequestDTOToJson(_MessageRequestDTO instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'message_text': instance.message,
      'message_type': instance.messageType,
      'receiver_id': instance.receiverId,
      'reply_to_message_id': instance.replyToMessageId,
    };
