import 'dart:async';
import 'package:fakegram/features/websocket/data/service/websocket_service.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_message_entity.dart';
import 'package:fakegram/features/websocket/domain/repository/websocket_repository.dart';
import 'package:flutter/foundation.dart';
import '../../../auth/domain/services/token_service.dart';


class WebSocketRepositoryImpl implements WebSocketRepository {
  final WebSocketService _webSocketService;
  final TokenService _tokenService;

  final StreamController<WebSocketEventEntity> _eventController =
  StreamController<WebSocketEventEntity>.broadcast();

  final StreamController<bool> _connectionController =
  StreamController<bool>.broadcast();

  bool _connectionStatus = false;
  bool _isConnecting = false;
  bool _shouldAutoReconnect = true;
  bool _isUnauthorizedError(String error) {
    return error.contains('401') ||
        error.contains('Unauthorized') ||
        error.contains('Token') ||
        error.contains('token');
  }
  Timer? _reconnectTimer;

  static const Duration _connectionTimeout = Duration(seconds: 5);

  WebSocketRepositoryImpl({
    required WebSocketService webSocketService,
    required TokenService tokenService,
  })  : _webSocketService = webSocketService,
        _tokenService = tokenService {
    _setupListeners();
  }

  void _setupListeners() {
    _webSocketService.onEvent = (event) {
      _eventController.add(event);
    };

    _webSocketService.onConnected = () {
      if (kDebugMode) {
        print('WebSocketRepository: Connected callback');
      }
      _connectionStatus = true;
      _isConnecting = false;
      _connectionController.add(true);
    };

    _webSocketService.onDisconnected = () {
      if (kDebugMode) {
        print('WebSocketRepository: Disconnected callback');
      }
      _handleConnectionLost();
      _scheduleReconnect();
    };

    _webSocketService.onError = (error) {
      if (kDebugMode) {
        print('WebSocketRepository: Error callback: $error');
      }
      if (_isUnauthorizedError(error)) {
        if (kDebugMode) {
          print('WebSocketRepository: 401 Unauthorized error detected');
        }
        _handleUnauthorizedError();
      } else {
        _handleConnectionLost();
        _scheduleReconnect();
      }
    };
  }

  Future<void> _handleUnauthorizedError() async {
    if (kDebugMode) {
      print('WebSocketRepository: Handling unauthorized error');
    }

    _handleConnectionLost();

    try {
      if (kDebugMode) {
        print('WebSocketRepository: Attempting to refresh token...');
      }

      await _tokenService.updateToken();

      if (kDebugMode) {
        print('WebSocketRepository: Token refreshed successfully, reconnecting...');
      }

      await disconnect();
      Future.delayed(const Duration(seconds: 1));
      await connect();
    } catch (e) {
      if (kDebugMode) {
        print('WebSocketRepository: Error during token refresh: $e');
      }
      _scheduleReconnect();
    }
  }

  void _handleConnectionLost() {
    if (_connectionStatus) {
      _connectionStatus = false;
      _isConnecting = false;
      _connectionController.add(false);
    }
  }

  @override
  Stream<WebSocketEventEntity> get eventStream => _eventController.stream;

  @override
  Stream<bool> get connectionStream => _connectionController.stream;

  @override
  Future<bool> get isConnected async => _connectionStatus;

  @override
  Future<void> connect() async {
    if (_isConnecting || _connectionStatus) {
      return;
    }

    _isConnecting = true;
    _shouldAutoReconnect = true;

    try {
      final token = await _tokenService.getAccessToken();
      if (token == null) {
        disconnect();
        throw Exception('No access token available');
      }

      const baseUrl = 'ws://localhost:8080';
      final url = '$baseUrl/api/v1/ws';

      if (kDebugMode) {
        print('WebSocketRepository: Connecting to $url');
      }

      final connectionFuture = _webSocketService.connect(url, token);
      final timeoutFuture = Future.delayed(
        _connectionTimeout,
            () => throw TimeoutException('WebSocket connection timeout'),
      );

      await Future.any([connectionFuture, timeoutFuture]);
      await connectionFuture;

      if (kDebugMode) {
        print('WebSocketRepository: Connection confirmed');
      }

    } on TimeoutException catch (e) {
      if (kDebugMode) {
        print('WebSocketRepository: Connection timeout');
      }
      _handleConnectionLost();
      _scheduleReconnect();
      rethrow;
    } catch (error) {
      if (kDebugMode) {
        print('WebSocketRepository: Connection failed: $error');
      }

      if (_isUnauthorizedError(error.toString())) {
        await _handleUnauthorizedError();
      } else {
        _handleConnectionLost();
        _scheduleReconnect();
      }

      rethrow;
    } finally {
      _isConnecting = false;
    }
  }

  void _scheduleReconnect() {
    if (!_shouldAutoReconnect || _reconnectTimer != null) {
      return;
    }

    if (kDebugMode) {
      print('WebSocketRepository: Scheduling reconnect in 3 seconds');
    }

    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      _reconnectTimer = null;
      if (_shouldAutoReconnect && !_connectionStatus && !_isConnecting) {
        connect().catchError((e) {
          if (kDebugMode) {
            print('WebSocketRepository: Auto-reconnect failed: $e');
          }
        });
      }
    });
  }

  @override
  Future<void> disconnect() async {
    _shouldAutoReconnect = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _isConnecting = false;

    try {
      await _webSocketService.disconnect();
    } catch (e) {
      if (kDebugMode) {
        print('Error during disconnect: $e');
      }
    } finally {
      _handleConnectionLost();
    }
  }

  @override
  void sendTypingStart(String chatId) {
    if (_connectionStatus) {
      try {
        final message = WebSocketMessageEntity(
          type: 'typing_start',
          payload: {'chat_id': chatId},
        );
        _webSocketService.sendMessage(message);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send typing_start: $e');
        }
      }
    }
  }

  @override
  void sendTypingStop(String chatId) {
    if (_connectionStatus) {
      try {
        final message = WebSocketMessageEntity(
          type: 'typing_stop',
          payload: {'chat_id': chatId},
        );
        _webSocketService.sendMessage(message);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send typing_stop: $e');
        }
      }
    }
  }

  @override
  void sendMessageRead(String chatId, String messageId) {
    if (_connectionStatus) {
      try {
        final message = WebSocketMessageEntity(
          type: 'message_read',
          payload: {
            'chat_id': chatId,
            'max_id': messageId,
          },
        );
        _webSocketService.sendMessage(message);
      } catch (e) {
        if (kDebugMode) {
          print('Failed to send message_read: $e');
        }
      }
    }
  }


  void dispose() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _eventController.close();
    _connectionController.close();
  }
}