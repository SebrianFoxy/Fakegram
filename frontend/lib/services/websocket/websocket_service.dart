// data/services/websocket_service.dart
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../../data/models/websocket/websocket_event/websocket_event_model.dart';
import '../../data/models/websocket/websocket_message/websocket_model.dart';
import '../../data/secure_storage/secure_storage.dart';
import '../../presenter/auth/notifier/auth_notifier.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _isRefreshing = false;
  bool _isReconnecting = false;
  String? _currentUrl;
  Timer? _reconnectTimer;

  Function(WebSocketEvent)? onEvent;
  Function(String)? onError;
  Function()? onConnected;
  Function()? onDisconnected;

  final AuthNotifier _authNotifier;

  WebSocketService(this._authNotifier);

  Future<void> connect(String url, String token) async {
    try {
      _currentUrl = url;
      _isReconnecting = false;
      debugPrint('Connecting to WebSocket...');

      _channel = IOWebSocketChannel.connect(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      _isConnected = true;

      _channel!.stream.listen(
        _handleMessage,
        onError: _handleError,
        onDone: _handleDisconnect,
      );

      //_sendAuthMessage(token);
      onConnected?.call();

      debugPrint('WebSocket connected successfully');

    } catch (e) {
      debugPrint('WebSocket connection failed: $e');
      _handleError(e);
    }
  }

  void _sendAuthMessage(String token) {
    final authMessage = WebSocketMessage(
      type: 'auth',
      payload: {'token': token},
    );
    _sendMessage(authMessage);
  }

  void sendTypingStart(String chatId) {
    final message = WebSocketMessage(
      type: 'typing_start',
      payload: {'chat_id': chatId},
    );
    _sendMessage(message);
  }

  void sendTypingStop(String chatId) {
    final message = WebSocketMessage(
      type: 'typing_stop',
      payload: {'chat_id': chatId},
    );
    _sendMessage(message);
  }

  void sendMessageRead(String chatId, String maxId) {
    final message = WebSocketMessage(
      type: 'message_read',
      payload: {
        'chat_id': chatId,
        'max_id': maxId,
      },
    );
    _sendMessage(message);
  }

  void _sendMessage(WebSocketMessage message) {
    if (_isConnected && _channel != null) {
      _channel!.sink.add(jsonEncode(message.toJson()));
    }
  }

  void _handleMessage(dynamic message) {
    try {
      debugPrint("🟢 WebSocket RAW message: $message");

      final jsonMessage = jsonDecode(message);
      debugPrint("🟢 WebSocket JSON keys: ${jsonMessage.keys}");

      final event = WebSocketEvent.fromJson(jsonMessage);

      if (event.event == 'token_expired' || event.event == 'unauthorized') {
        _handleTokenExpired();
        return;
      }

      onEvent?.call(event);
    } catch (e) {
      debugPrint('WebSocket message parsing error: $e');
    }
  }

  void _handleError(dynamic error) {
    debugPrint('WebSocket _handleError: $error');

    final errorString = error.toString();

    if (errorString.contains('401') ||
        errorString.contains('unauthorized') ||
        errorString.contains('token')) {
      _handleTokenExpired();
    } else {
      onError?.call(errorString);
      _scheduleReconnect();
    }
  }

  Future<void> _handleTokenExpired() async {
    debugPrint('Token expired, attempting refresh...');

    try {
      await _authNotifier.tokenUpdate(false);
      final newToken = await SecureStorage().readSecureData('accessToken');

      if (_currentUrl != null && newToken != null) {
        debugPrint('Reconnecting with new token...');
        await disconnect();
        await connect(_currentUrl!, newToken);
      } else {
        debugPrint('Cannot reconnect: URL or token is null');
        _scheduleReconnect();
      }

    } catch (e) {
      debugPrint('Token refresh failed: $e');
      onError?.call('Authentication failed. Please reconnect.');
      _scheduleReconnect();
    } finally {
      _isRefreshing = false;
    }
  }

  void _handleDisconnect() {
    if (_isConnected) {
      _isConnected = false;
      onDisconnected?.call();
      _scheduleReconnect();
    }
  }

  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _isConnected = false;
    await _channel?.sink.close();
    _channel = null;
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    if (_isReconnecting) {
      debugPrint('Already scheduled to reconnect, skipping...');
      return;
    }

    _isReconnecting = true;
    debugPrint('Scheduling reconnect in 5 seconds...');

    _reconnectTimer = Timer(const Duration(seconds: 5), () async {
      _isReconnecting = false;
      if (!_isConnected) {
        try {
          debugPrint('Attempting to reconnect...');
          final token = await SecureStorage().readSecureData('accessToken');
          if (_currentUrl != null && token != null) {
            await connect(_currentUrl!, token);
          } else {
            debugPrint('Cannot reconnect: URL or token is null');
          }
        } catch (e) {
          debugPrint('Reconnect failed: $e');
          _scheduleReconnect();
        }
      }
    });
  }

  bool get isConnected => _isConnected;
}