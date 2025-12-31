import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_event_entity.freezed.dart';

@freezed
abstract class WebSocketEventEntity with _$WebSocketEventEntity {
  const factory WebSocketEventEntity({
    required String event,
    required Map<String, dynamic> data,
  }) = _WebSocketEventEntity;

  const WebSocketEventEntity._();
}