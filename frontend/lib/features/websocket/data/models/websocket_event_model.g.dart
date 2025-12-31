// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WebSocketEventModel _$WebSocketEventModelFromJson(Map<String, dynamic> json) =>
    _WebSocketEventModel(
      type: json['type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WebSocketEventModelToJson(
        _WebSocketEventModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload,
    };
