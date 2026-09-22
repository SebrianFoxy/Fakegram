// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_read_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageReadInfoModel _$MessageReadInfoModelFromJson(
        Map<String, dynamic> json) =>
    _MessageReadInfoModel(
      userId: json['user_id'] as String,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      nickname: json['nickname'] as String? ?? '',
      avatarUrl: json['avatar_url'] as String?,
      readAt: DateTime.parse(json['read_at'] as String),
    );

Map<String, dynamic> _$MessageReadInfoModelToJson(
        _MessageReadInfoModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'name': instance.name,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'avatar_url': instance.avatarUrl,
      'read_at': instance.readAt.toIso8601String(),
    };
