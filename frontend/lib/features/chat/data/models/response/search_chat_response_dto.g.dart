// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_chat_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchChatResponseDTO _$SearchChatResponseDTOFromJson(
        Map<String, dynamic> json) =>
    _SearchChatResponseDTO(
      chats: (json['chats'] as List<dynamic>)
          .map((e) => DirectChatModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
      query: json['query'] as String,
    );

Map<String, dynamic> _$SearchChatResponseDTOToJson(
        _SearchChatResponseDTO instance) =>
    <String, dynamic>{
      'chats': instance.chats,
      'count': instance.count,
      'query': instance.query,
    };
