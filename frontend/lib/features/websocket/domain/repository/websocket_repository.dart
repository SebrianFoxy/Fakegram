import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';

abstract class WebSocketRepository {
  Stream<WebSocketEventEntity> get eventStream;
  Future<void> connect();
  Future<void> disconnect();
  Stream<bool> get connectionStream;
  Future<bool> get isConnected;

  void sendTypingStart(String chatId);
  void sendTypingStop(String chatId);
  void sendMessageRead(String chatId, String messageId);
}