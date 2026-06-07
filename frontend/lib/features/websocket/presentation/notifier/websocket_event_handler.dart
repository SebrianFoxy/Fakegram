import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/websocket_event_entity.dart';

abstract class WebSocketEventHandler {
  bool canHandle(WebSocketEventEntity event);

  void handle(WebSocketEventEntity event, Ref ref);
}