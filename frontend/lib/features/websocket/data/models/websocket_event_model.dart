import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_event_model.freezed.dart';
part 'websocket_event_model.g.dart';

@freezed
abstract class WebSocketEventModel with _$WebSocketEventModel {
  const factory WebSocketEventModel({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketEventModel;

  const WebSocketEventModel._();

  factory WebSocketEventModel.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventModelFromJson(json);

  WebSocketEventEntity toEntity() {
    final eventName = payload['event'] as String? ?? '';
    final eventData = payload['data'] as Map<String, dynamic>? ?? {};

    return WebSocketEventEntity(
      event: eventName,
      data: eventData,
    );
  }
}