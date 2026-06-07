import 'dart:async';
import 'package:fakegram/features/chat/presentation/notifier/message/message_websocket_event_handler.dart';
import 'package:fakegram/features/websocket/presentation/notifier/websocket_event_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../auth/presentation/notifier/auth_notifier.dart';
import '../../../chat/presentation/notifier/chat/chat_websocket_event_handler.dart';
import '../../domain/entities/websocket_event_entity.dart';
import '../../domain/repository/websocket_repository.dart';
import 'connection_manager.dart';
import 'event_router.dart';

part 'websocket_notifier.g.dart';
part 'websocket_notifier.freezed.dart';
part 'websocket_state.dart';

@riverpod
class WebSocketNotifier extends _$WebSocketNotifier {
  late final ConnectionManager _connectionManager;
  late final EventRouter _eventRouter;
  StreamSubscription<WebSocketEventEntity>? _eventSubscription;
  StreamSubscription<bool>? _connectionSubscription;

  @override
  WebSocketState build() {
    _connectionManager = ConnectionManager(
      ref.read(webSocketRepositoryProvider),
    );
    _eventRouter = EventRouter();

    _registerEventHandlers();
    _setupConnectionListener();
    _checkInitialConnection();

    ref.onDispose(_dispose);

    return const WebSocketState.disconnected();
  }

  void _registerEventHandlers() {
    _eventRouter
      ..registerHandler(ChatEventHandler())
      ..registerHandler(MessageEventHandler());
  }

  void _setupConnectionListener() {
    _connectionSubscription = _connectionManager.connectionStream.listen(
      _onConnectionStateChanged,
    );
  }

  void _onConnectionStateChanged(bool isConnected) {
    if (isConnected && state is! _Connected) {
      state = const WebSocketState.connected();
      _subscribeToEvents(ref);
    } else if (!isConnected && state is _Connected) {
      _handleConnectionLost();
    }
  }

  void _checkInitialConnection() {
    Future.microtask(() async {
      if (await _connectionManager.isConnected && state is! _Connected) {
        state = const WebSocketState.connected();
        _subscribeToEvents(ref);
      }
    });
  }

  void _subscribeToEvents(Ref ref) {
    _eventSubscription?.cancel();
    _eventSubscription = _connectionManager.eventStream.listen(
          (event) => _eventRouter.handleEvent(event, ref),
      onError: _onEventStreamError,
      onDone: _onEventStreamDone,
    );
  }

  void _onEventStreamError(Object error) {
    debugPrint('WebSocket event stream error: $error');
  }

  void _onEventStreamDone() {
    debugPrint('WebSocket event stream completed');
    if (!_connectionManager.isManuallyDisconnecting) {
      _handleConnectionLost();
    }
  }

  void _handleConnectionLost() {
    if (_connectionManager.isManuallyDisconnecting) return;

    state = const WebSocketState.disconnected();
    _scheduleReconnect();
  }

  void _scheduleReconnect() {
    _connectionManager.scheduleReconnect(() async {
      if (!_connectionManager.isManuallyDisconnecting && state is! _Connected) {
        await _attemptReconnect();
      }
    });
  }

  Future<void> _attemptReconnect() async {
    try {
      await _connectionManager.connect();
    } catch (error) {
      _logError('WebSocket reconnect attempt failed', error);
      _scheduleReconnect();
    }
  }

  Future<void> connect() async {
    if (!_canConnect) return;

    state = const WebSocketState.connecting();

    try {
      await _connectionManager.connect();
    } catch (error) {
      _handleConnectionError(error);
    }
  }

  Future<void> disconnect() async {
    if (!_canDisconnect) return;

    state = const WebSocketState.disconnecting();

    try {
      await _connectionManager.disconnect();
      state = const WebSocketState.disconnected();
    } catch (error) {
      state = WebSocketState.error(error: error.toString());
    } finally {
      _eventSubscription?.cancel();
      _eventSubscription = null;
    }
  }

  void sendTypingStart(String chatId) {
    _executeIfConnected((repo) => repo.sendTypingStart(chatId));
  }

  void sendTypingStop(String chatId) {
    _executeIfConnected((repo) => repo.sendTypingStop(chatId));
  }

  void sendMessageRead(String chatId, String messageId) {
    _executeIfConnected((repo) => repo.sendMessageRead(chatId, messageId));
  }

  void sendMessageAllRead(String chatId) {
    _executeIfConnected((repo) => repo.sendMessageAllRead(chatId));
  }

  void registerEventHandler(WebSocketEventHandler handler) {
    _eventRouter.registerHandler(handler);
  }

  void _executeIfConnected(void Function(WebSocketRepository) action) {
    if (state is _Connected) {
      action(ref.read(webSocketRepositoryProvider));
    }
  }

  void _handleConnectionError(Object error) {
    _logError('WebSocket connection error', error);
    final exception = ErrorHandler.handleError(error);
    state = WebSocketState.error(error: exception.message);
    _scheduleReconnect();
  }

  void _logError(String message, Object error) {
    if (kDebugMode) {
      print('$message: $error');
    }
  }

  void _dispose() {
    _connectionManager.dispose();
    _eventSubscription?.cancel();
    _connectionSubscription?.cancel();
    _eventRouter.dispose();
  }

  bool get _canConnect => state is! _Connecting && state is! _Connected;
  bool get _canDisconnect => state is! _Disconnected && state is! _Disconnecting;

  bool get isConnected => state is _Connected;
  bool get isConnecting => state is _Connecting;
  bool get isDisconnected => state is _Disconnected;
  bool get hasError => state is _Error;
  String? get error => state is _Error ? (state as _Error).error : null;
}

@riverpod
WebSocketRepository webSocketRepository(Ref ref) {
  return getIt<WebSocketRepository>();
}

@riverpod
bool isWebSocketConnected(Ref ref) {
  return ref.watch(webSocketProvider) is _Connected;
}

@riverpod
Future<void> autoConnectWebSocket(Ref ref) async {
  try {
    final isAuthenticated = ref.read(authProvider).isAuthenticated;
    if (!isAuthenticated) return;

    await Future.delayed(const Duration(seconds: 2));

    final state = ref.read(webSocketProvider);
    if (state is! _Connected && state is! _Connecting) {
      await ref.read(webSocketProvider.notifier).connect();
    }
  } catch (e) {
    if (kDebugMode) {
      print('⚠️ autoConnectWebSocket error: $e');
    }
  }
}