// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_user_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageUserDetailModel _$MessageUserDetailModelFromJson(
        Map<String, dynamic> json) =>
    _MessageUserDetailModel(
      name: json['name'] as String,
      surname: json['surname'] as String,
      nickname: json['nickname'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$MessageUserDetailModelToJson(
        _MessageUserDetailModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'nickname': instance.nickname,
      'avatar_url': instance.avatarUrl,
    };
