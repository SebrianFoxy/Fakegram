part of 'websocket_notifier.dart';

@freezed
abstract class WebSocketState with _$WebSocketState {
  const factory WebSocketState.disconnected() = _Disconnected;
  const factory WebSocketState.connecting() = _Connecting;
  const factory WebSocketState.connected({
    DateTime? lastConnected,
  }) = _Connected;
  const factory WebSocketState.disconnecting() = _Disconnecting;
  const factory WebSocketState.error({
    required String error,
    DateTime? lastError,
  }) = _Error;
}