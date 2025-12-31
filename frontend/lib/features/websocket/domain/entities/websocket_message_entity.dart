import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_message_entity.freezed.dart';

@freezed
abstract class WebSocketMessageEntity with _$WebSocketMessageEntity {
  const factory WebSocketMessageEntity({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketMessageEntity;

  const WebSocketMessageEntity._();
}