// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_group_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatGroupRequestDTO _$ChatGroupRequestDTOFromJson(Map<String, dynamic> json) =>
    _ChatGroupRequestDTO(
      title: json['title'] as String,
      membersIDs: (json['member_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      avatarUrl: json['avatar_url'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ChatGroupRequestDTOToJson(
        _ChatGroupRequestDTO instance) =>
    <String, dynamic>{
      'title': instance.title,
      'member_ids': instance.membersIDs,
      'avatar_url': instance.avatarUrl,
      'description': instance.description,
    };
