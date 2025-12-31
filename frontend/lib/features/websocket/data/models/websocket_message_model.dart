import 'package:fakegram/features/websocket/domain/entities/websocket_message_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'websocket_message_model.freezed.dart';
part 'websocket_message_model.g.dart';

@freezed
abstract class WebSocketMessageModel with _$WebSocketMessageModel {
  const factory WebSocketMessageModel({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketMessageModel;

  const WebSocketMessageModel._();

  factory WebSocketMessageModel.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageModelFromJson(json);

  WebSocketMessageEntity toEntity() => WebSocketMessageEntity(
    type: type,
    payload: payload,
  );
}