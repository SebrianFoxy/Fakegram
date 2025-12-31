import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_message_entity.dart';

abstract class WebSocketService {
  Future<void> connect(String url, String token);
  Future<void> disconnect();
  void sendMessage(WebSocketMessageEntity message);

  Function(WebSocketEventEntity)? onEvent;
  Function(String)? onError;
  Function()? onConnected;
  Function()? onDisconnected;

  bool get isConnected;
}