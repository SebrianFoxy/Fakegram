import 'dart:async';
import 'package:flutter/foundation.dart';
import '../../domain/entities/websocket_event_entity.dart';
import '../../domain/repository/websocket_repository.dart';

class ConnectionManager {
  final WebSocketRepository _repository;
  Timer? _reconnectTimer;
  bool _isManuallyDisconnecting = false;
  int _reconnectAttempts = 0;

  static const _maxReconnectAttempts = 5;
  static const _reconnectDelay = Duration(seconds: 3);

  ConnectionManager(this._repository);

  bool get isManuallyDisconnecting => _isManuallyDisconnecting;
  Future<bool> get isConnected => _repository.isConnected;
  Stream<bool> get connectionStream => _repository.connectionStream;
  Stream<WebSocketEventEntity> get eventStream => _repository.eventStream;

  Future<void> connect() async {
    _isManuallyDisconnecting = false;
    _cancelReconnectTimer();
    _reconnectAttempts = 0;
    await _repository.connect();
  }

  Future<void> disconnect() async {
    _isManuallyDisconnecting = true;
    _cancelReconnectTimer();
    _reconnectAttempts = 0;
    await _repository.disconnect();
  }

  void scheduleReconnect(Future<void> Function() onAttempt) {
    if (_reconnectAttempts >= _maxReconnectAttempts) {
      _logMaxAttemptsReached();
      return;
    }

    _cancelReconnectTimer();
    _reconnectTimer = Timer(_reconnectDelay, () async {
      _reconnectTimer = null;
      _reconnectAttempts++;
      await onAttempt();
    });
  }

  void _cancelReconnectTimer() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
  }

  void _logMaxAttemptsReached() {
    if (kDebugMode) {
      print('⚠️ Max reconnection attempts reached');
    }
  }

  void dispose() {
    _isManuallyDisconnecting = true;
    _cancelReconnectTimer();
  }
}