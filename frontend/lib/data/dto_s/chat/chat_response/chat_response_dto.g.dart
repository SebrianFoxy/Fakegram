// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatResponseDTO _$ChatResponseDTOFromJson(Map<String, dynamic> json) =>
    _ChatResponseDTO(
      chats: (json['chats'] as List<dynamic>)
          .map((e) => DirectChatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$ChatResponseDTOToJson(_ChatResponseDTO instance) =>
    <String, dynamic>{
      'chats': instance.chats,
      'count': instance.count,
    };
