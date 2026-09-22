import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import '../../domain/entities/websocket_event_entity.dart';
import '../../domain/repository/websocket_repository.dart';

class ConnectionManager {
  final WebSocketRepository _repository;
  Timer? _reconnectTimer;
  bool _isManuallyDisconnecting = false;
  int _reconnectAttempts = 0;

  static const _maxReconnectAttempts = 5;

  ConnectionManager(this._repository);

  bool get isManuallyDisconnecting => _isManuallyDisconnecting;
  Future<bool> get isConnected => _repository.isConnected;
  Stream<bool> get connectionStream => _repository.connectionStream;
  Stream<WebSocketEventEntity> get eventStream => _repository.eventStream;

  Future<void> connect() async {
    _isManuallyDisconnecting = false;
    _cancelReconnectTimer();
    try {
      await _repository.connect();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConnectionManager: connect failed: $e');
      }
    }
  }

  Future<void> disconnect() async {
    _isManuallyDisconnecting = true;
    _cancelReconnectTimer();
    _reconnectAttempts = 0;
    try {
      await _repository.disconnect();
    } catch (e) {
      if (kDebugMode) {
        debugPrint('ConnectionManager: disconnect failed: $e');
      }
    }
  }

  void resetReconnectAttempts() {
    _reconnectAttempts = 0;
  }

  void scheduleReconnect(Future<void> Function() onAttempt) {
    if (_isManuallyDisconnecting) return;
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logMaxAttemptsReached();
      return;
    }

    _cancelReconnectTimer();
    final delay = _delayForAttempt(_reconnectAttempts);
    _reconnectTimer = Timer(delay, () async {
      _reconnectTimer = null;
      if (_isManuallyDisconnecting) return;
      _reconnectAttempts++;
      try {
        await onAttempt();
      } catch (e) {
        if (kDebugMode) {
          debugPrint('⚠️ Reconnect attempt failed: $e');
        }
      }
    });
  }

  Duration _delayForAttempt(int attempt) {
    final seconds = math.min(30, math.pow(2, attempt).toInt());
    return Duration(seconds: seconds);
  }

  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void _logMaxAttemptsReached() {
    if (kDebugMode) {
      debugPrint('⚠️ Max reconnection attempts reached');
    }
  }

  void dispose() {
    _isManuallyDisconnecting = true;
    _cancelReconnectTimer();
  }
}