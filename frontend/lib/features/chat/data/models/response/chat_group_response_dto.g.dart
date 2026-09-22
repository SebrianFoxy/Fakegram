// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatGroupResponseDTO _$ChatGroupResponseDTOFromJson(
        Map<String, dynamic> json) =>
    _ChatGroupResponseDTO(
      chat: DirectChatModel.fromJson(json['chat'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ChatGroupResponseDTOToJson(
        _ChatGroupResponseDTO instance) =>
    <String, dynamic>{
      'chat': instance.chat,
    };
