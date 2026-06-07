import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/websocket_event_entity.dart';
import 'websocket_event_handler.dart';

class EventRouter {
  final List<WebSocketEventHandler> _handlers = [];

  void registerHandler(WebSocketEventHandler handler) {
    _handlers.add(handler);
  }

  void handleEvent(WebSocketEventEntity event, Ref ref) {
    _logEvent(event);

    for (final handler in _handlers) {
      if (handler.canHandle(event)) {
        _executeHandler(handler, event, ref);
        return;
      }
    }

    _logUnhandledEvent(event);
  }

  void _executeHandler(
      WebSocketEventHandler handler,
      WebSocketEventEntity event,
      Ref ref,
      ) {
    try {
      handler.handle(event, ref);
    } catch (e, stackTrace) {
      _logHandlerError(event, e, stackTrace);
    }
  }

  void _logEvent(WebSocketEventEntity event) {
    if (kDebugMode) {
      print('📨 WebSocket event: ${event.event}');
    }
  }

  void _logUnhandledEvent(WebSocketEventEntity event) {
    if (kDebugMode) {
      print('⚠️ No handler found for event: ${event.event}');
    }
  }

  void _logHandlerError(WebSocketEventEntity event, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      print('❌ Error handling WebSocket event ${event.event}: $error');
      print(stackTrace);
    }
  }

  void dispose() {
    _handlers.clear();
  }
}