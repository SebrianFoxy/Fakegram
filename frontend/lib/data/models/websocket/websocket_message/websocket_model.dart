import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_model.freezed.dart';
part 'websocket_model.g.dart';

@freezed
abstract class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);
}