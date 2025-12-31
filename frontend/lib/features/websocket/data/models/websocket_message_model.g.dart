// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebSocketMessageModel _$WebSocketMessageModelFromJson(
        Map<String, dynamic> json) =>
    _WebSocketMessageModel(
      type: json['type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WebSocketMessageModelToJson(
        _WebSocketMessageModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload,
    };
