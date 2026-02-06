// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SendMessageResponseDTO _$SendMessageResponseDTOFromJson(
        Map<String, dynamic> json) =>
    _SendMessageResponseDTO(
      chatId: json['chat_id'] as String,
      message:
          MessageDetailModel.fromJson(json['message'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SendMessageResponseDTOToJson(
        _SendMessageResponseDTO instance) =>
    <String, dynamic>{
      'chat_id': instance.chatId,
      'message': instance.message,
    };
