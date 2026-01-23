import 'dart:async';
import 'dart:convert';
import 'package:fakegram/features/websocket/data/models/websocket_event_model.dart';
import 'package:fakegram/features/websocket/data/service/websocket_service.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_message_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketServiceImpl implements WebSocketService {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _isConnecting = false;
  bool _shouldReconnect = true;
  String? _currentUrl;
  String? _currentToken;
  Timer? _reconnectTimer;
  Completer<void>? _connectionCompleter;
  StreamSubscription<dynamic>? _streamSubscription;

  @override
  Function(WebSocketEventEntity)? onEvent;
  @override
  Function(String)? onError;
  @override
  Function()? onConnected;
  @override
  Function()? onDisconnected;

  @override
  Future<void> connect(String url, String token) async {
    if (_isConnecting || _isConnected) {
      return;
    }

    print(token);

    _currentUrl = url;
    _currentToken = token;
    _isConnecting = true;
    _isConnected = false;
    _shouldReconnect = true;
    _connectionCompleter = Completer<void>();

    if (kDebugMode) {
      print('WebSocket: Connecting to $url');
    }

    try {
      _channel = await Future<WebSocketChannel>(() {
        try {
          return IOWebSocketChannel.connect(
            Uri.parse(url),
            headers: {
              'Authorization': 'Bearer $token',
            },
          );
        } catch (e) {
          throw Exception('Failed to create WebSocket: $e');
        }
      });

      _streamSubscription = _channel!.stream.listen(
        _handleMessage,
        onError: (error) {
          if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
            _connectionCompleter!.completeError(error);
          }
          _handleError(error);
        },
        onDone: () {
          if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
            _connectionCompleter!.completeError(
              Exception('Connection closed'),
            );
          }
          _handleDisconnect();
        },
      );

      Future.delayed(const Duration(seconds: 5), () {
        if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
          _connectionCompleter!.completeError(
            TimeoutException('WebSocket connection timeout'),
          );
        }
      });

      await _connectionCompleter!.future;

      _isConnected = true;
      _isConnecting = false;

      onConnected?.call();

      if (kDebugMode) {
        print('WebSocket: Connected successfully');
      }

    } catch (e) {
      _cleanup();

      if (kDebugMode) {
        print('WebSocket: Connection failed: $e');
      }

      _scheduleReconnect();
      rethrow;
    } finally {
      _isConnecting = false;
    }
  }

  void _cleanup() {
    _isConnecting = false;
    _isConnected = false;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _channel = null;
  }

  @override
  Future<void> disconnect() async {
    _shouldReconnect = false;
    _reconnectTimer?.cancel();

    try {
      await _channel?.sink.close();
    } catch (e) {
      debugPrint('WebsocketServiceDisconnect error: $e');
    }
    _cleanup();

    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      _connectionCompleter!.completeError(Exception('Manually disconnected'));
    }
    _connectionCompleter = null;

    onDisconnected?.call();
  }

  void _handleError(dynamic error) {
    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      _connectionCompleter!.completeError(error);
    }

    if (kDebugMode) {
      print('WebSocket stream error: $error');
    }

    _cleanup();
    onDisconnected?.call();
    _scheduleReconnect();
  }

  void _handleDisconnect() {
    if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
      _connectionCompleter!.completeError(Exception('Connection closed'));
    }

    _cleanup();
    onDisconnected?.call();
    _scheduleReconnect();
  }

  @override
  void sendMessage(WebSocketMessageEntity message) {
    if (_isConnected && _channel != null) {
      try {
        final jsonMessage = jsonEncode({
          'type': message.type,
          'payload': message.payload,
        });

        _channel!.sink.add(jsonMessage);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send WebSocket message: $e');
        }
      }
    }
  }

  void _handleMessage(dynamic message) {
    try {
      if (kDebugMode) {
        print('WebSocket: Received message: $message');
      }

      final jsonMessage = jsonDecode(message);
      final event = WebSocketEventModel.fromJson(jsonMessage).toEntity();

      if (_connectionCompleter != null && !_connectionCompleter!.isCompleted) {
        _connectionCompleter!.complete();
      }
      onEvent?.call(event);
    } catch (e) {
      if (kDebugMode) {
        print('WebSocket: Message parsing error: $e');
      }
      onError?.call('Message parsing error: $e');
    }
  }

  void _scheduleReconnect() {
    if (!_shouldReconnect || _reconnectTimer != null) {
      return;
    }
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      _reconnectTimer = null;
      if (_shouldReconnect && !_isConnected && !_isConnecting && _currentUrl != null && _currentToken != null) {
        connect(_currentUrl!, _currentToken!);
      }
    });
  }
}