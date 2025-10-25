// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'direct_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DirectMessageModel _$DirectMessageModelFromJson(Map<String, dynamic> json) =>
    _DirectMessageModel(
      id: json['id'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      text: json['text'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
      isDelivered: json['isDelivered'] as bool? ?? false,
    );

Map<String, dynamic> _$DirectMessageModelToJson(_DirectMessageModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
      'isDelivered': instance.isDelivered,
    };
