// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageResponseDTO _$MessageResponseDTOFromJson(Map<String, dynamic> json) =>
    _MessageResponseDTO(
      messages: (json['messages'] as List<dynamic>)
          .map((e) => MessageDetailModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      count: (json['count'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      page: (json['page'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      hasNext: json['has_next'] as bool,
      hasPrev: json['has_prev'] as bool,
    );

Map<String, dynamic> _$MessageResponseDTOToJson(_MessageResponseDTO instance) =>
    <String, dynamic>{
      'messages': instance.messages,
      'count': instance.count,
      'total': instance.total,
      'page': instance.page,
      'limit': instance.limit,
      'has_next': instance.hasNext,
      'has_prev': instance.hasPrev,
    };
