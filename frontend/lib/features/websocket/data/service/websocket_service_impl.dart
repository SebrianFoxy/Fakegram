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
  String? _currentUrl;
  String? _currentToken;
  Timer? _connectionTimeoutTimer;
  Completer<void>? _connectionCompleter;
  StreamSubscription<dynamic>? _streamSubscription;
  bool _notifiedDisconnect = false;

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
    if (_isConnecting || _isConnected) return;

    _currentUrl = url;
    _currentToken = token;
    _isConnecting = true;
    _isConnected = false;
    _connectionCompleter = Completer<void>();

    if (kDebugMode) {
      debugPrint('WebSocket: Connecting to $url');
    }

    try {
      final Uri uri;
      final Map<String, dynamic>? headers;

      if (kIsWeb) {
        final parsed = Uri.parse(url);
        uri = parsed.replace(queryParameters: {
          ...parsed.queryParameters,
          'token': token,
        });
        headers = null;
      } else {
        uri = Uri.parse(url);
        headers = {'Authorization': 'Bearer $token'};
      }

      if (kDebugMode) {
        debugPrint('Platform: ${kIsWeb ? "WEB" : "DESKTOP"}');
        debugPrint('Final URL: $uri');
        if (headers != null) debugPrint('Headers: $headers');
      }

      _channel = kIsWeb
          ? WebSocketChannel.connect(uri)
          : IOWebSocketChannel.connect(uri, headers: headers);

      _streamSubscription = _channel!.stream.listen(
        _handleMessage,
        onError: (error) {
          _completeConnectionWithError(error);
          _handleError(error);
        },
        onDone: () {
          _completeConnectionWithError(Exception('Connection closed'));
          _handleDisconnect();
        },
      );

      _connectionTimeoutTimer?.cancel();
      _connectionTimeoutTimer = Timer(const Duration(seconds: 5), () {
        _completeConnectionWithError(
          TimeoutException('WebSocket connection timeout'),
        );
      });

      await _connectionCompleter!.future;

      _connectionTimeoutTimer?.cancel();
      _connectionTimeoutTimer = null;
      _isConnected = true;
      _isConnecting = false;
      _notifiedDisconnect = false;
      onConnected?.call();

      if (kDebugMode) {
        debugPrint('WebSocket: Connected successfully');
      }
    } catch (e) {
      _cleanup();
      if (kDebugMode) {
        debugPrint('WebSocket: Connection failed: $e');
      }
      _notifyDisconnectOnce();
      rethrow;
    } finally {
      _isConnecting = false;
    }
  }

  void _notifyDisconnectOnce() {
    if (_notifiedDisconnect) return;
    _notifiedDisconnect = true;
    onError?.call('WebSocket connection failed');
    onDisconnected?.call();
  }

  void _completeConnectionWithError(Object error) {
    final completer = _connectionCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.completeError(error);
    }
  }

  void _completeConnection() {
    final completer = _connectionCompleter;
    if (completer != null && !completer.isCompleted) {
      completer.complete();
    }
  }

  void _cleanup() {
    _isConnecting = false;
    _isConnected = false;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    _channel = null;
    _connectionTimeoutTimer?.cancel();
    _connectionTimeoutTimer = null;
  }

  @override
  Future<void> disconnect() async {
    try {
      await _channel?.sink.close();
    } catch (e) {
      debugPrint('WebSocketServiceDisconnect error: $e');
    }

    _cleanup();
    _completeConnectionWithError(Exception('Manually disconnected'));
    _connectionCompleter = null;
    _currentUrl = null;
    _currentToken = null;
    _notifiedDisconnect = true;
    onDisconnected?.call();
  }

  void _handleError(dynamic error) {
    _completeConnectionWithError(error);
    if (kDebugMode) {
      debugPrint('WebSocket stream error: $error');
    }
    _cleanup();
    _notifyDisconnectOnce();
  }

  void _handleDisconnect() {
    _completeConnectionWithError(Exception('Connection closed'));
    _cleanup();
    _notifyDisconnectOnce();
  }

  @override
  void sendMessage(WebSocketMessageEntity message) {
    if (!_isConnected || _channel == null) return;

    try {
      final jsonMessage = jsonEncode({
        'type': message.type,
        'payload': message.payload,
      });
      _channel!.sink.add(jsonMessage);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('Failed to send WebSocket message: $e');
      }
    }
  }

  void _handleMessage(dynamic message) {
    try {
      if (kDebugMode) {
        debugPrint('WebSocket: Received message: $message');
      }

      final jsonMessage = jsonDecode(message);

      if (jsonMessage is Map && jsonMessage['type'] == 'error') {
        if (kDebugMode) {
          debugPrint('WebSocket: Error message received: $jsonMessage');
        }
        onError?.call(jsonMessage.toString());
        return;
      }

      final event = WebSocketEventModel.fromJson(jsonMessage).toEntity();

      _completeConnection();
      onEvent?.call(event);
    } catch (e) {
      if (kDebugMode) {
        debugPrint('WebSocket: Message parsing error: $e');
      }
      onError?.call('Message parsing error: $e');
    }
  }
}