import 'dart:async';
import 'package:fakegram/features/auth/presentation/notifier/auth_notifier.dart';
import 'package:fakegram/features/chat/domain/entities/message_read_all_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fakegram/core/di/service_locator.dart';
import 'package:fakegram/features/websocket/domain/entities/websocket_event_entity.dart';
import 'package:fakegram/features/websocket/domain/repository/websocket_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../chat/domain/entities/message_read_entity.dart';
import '../../../chat/presentation/notifier/chat/chat_notifier.dart';
import '../../../chat/presentation/notifier/message/message_notifier.dart';
import '../providers/websocket_providers.dart';

part 'websocket_notifier.g.dart';
part 'websocket_notifier.freezed.dart';
part 'websocket_state.dart';

@riverpod
class WebSocketNotifier extends _$WebSocketNotifier {
  WebSocketRepository get _repository => getIt<WebSocketRepository>();
  StreamSubscription<WebSocketEventEntity>? _eventSubscription;
  StreamSubscription<bool>? _connectionSubscription;
  Timer? _reconnectTimer;
  bool _isManuallyDisconnecting = false;

  @override
  WebSocketState build() {
    _connectionSubscription = _repository.connectionStream.listen(
          (isConnected) {
        if (isConnected && state is! _Connected) {
          state = const WebSocketState.connected();
          _subscribeToEvents();
        } else if (!isConnected && state is _Connected) {
          _handleConnectionLost();
        }
      },
    );

    Future.microtask(() async {
      if (await _repository.isConnected && state is! _Connected) {
        state = const WebSocketState.connected();
        _subscribeToEvents();
      }
    });

    ref.onDispose(() {
      _dispose();
    });

    return const WebSocketState.disconnected();
  }

  void _dispose() {
    _isManuallyDisconnecting = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;
    _eventSubscription?.cancel();
    _connectionSubscription?.cancel();
  }

  void _subscribeToEvents() {
    _eventSubscription?.cancel();
    _eventSubscription = _repository.eventStream.listen(
          (event) {
        _handleWebSocketEvent(event);
      },
      onError: (error) {
        debugPrint('WebSocket event stream error: $error');
      },
      onDone: () {
        debugPrint('WebSocket event stream completed');
        if (!_isManuallyDisconnecting) {
          _handleConnectionLost();
        }
      },
    );
  }

  void _handleConnectionLost() {
    if (!_isManuallyDisconnecting) {
      state = const WebSocketState.disconnected();
      _scheduleReconnect();
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    _reconnectTimer = Timer(const Duration(seconds: 3), () async {
      _reconnectTimer = null;
      if (!_isManuallyDisconnecting && state is! _Connected) {
        await _attemptReconnect();
      }
    });
  }

  Future<void> _attemptReconnect() async {
    try {
      await _repository.connect();
    } catch (error) {
      if (kDebugMode) {
        print('WebSocket reconnect attempt failed: $error');
      }
      _scheduleReconnect();
    }
  }

  void _handleWebSocketEvent(WebSocketEventEntity event) {
    if (kDebugMode) {
      print('📨 WebSocket event: ${event.event}');
    }

    try {
      switch (event.event) {
        case 'chat_list_update':
          ref.read(chatUpdateProvider.notifier).update(event.data);
          break;
        case 'new_chat_created':
          ref.read(newChatProvider.notifier).update(event.data);
          break;
        case 'message_list_update':
          _handleMessageListUpdate(event.data);
          break;
        case 'message_sent':
          ref.read(newMessageProvider.notifier).update(event.data);
          break;
        case 'message_read':
          _handleMessageRead(event.data);
          break;
        case 'message_read_all':
          _handleMessageAllRead(event.data);
          break;
        case 'user_typing':
          ref.read(typingStatusProvider.notifier).update(event.data);
          break;
        case 'unread_count_update':
          ref.read(unreadCountUpdateProvider.notifier).update(event.data);
          break;
        case 'user_online':
          ref.read(userOnlineStatusProvider.notifier).update(event.data);
          break;
        case 'user_offline':
          ref.read(userOnlineStatusProvider.notifier).update(event.data);
          break;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('❌ Error handling WebSocket event ${event.event}: $e');
        print(stackTrace);
      }
    }
  }

  void _handleMessageListUpdate(Map<String, dynamic> data) {
    final action = data['action'] as String?;

    if (action == 'new_message') {
      ref.read(newMessageFromSocketProvider.notifier).update(data);
    } else if (action == 'new_message_sent') {
      ref.read(messageSentConfirmationProvider.notifier).update(data);
    } else if (action == 'message_status_update') {
      ref.read(messageStatusUpdateProvider.notifier).update(data);
    } else if (action == 'message_deleted' || action == 'message_deleted_confirm') {
      ref.read(messageDeletedProvider.notifier).update(data);
    }
  }

  void _handleMessageRead(Map<String, dynamic> data) {
    try {
      final readEntity = MessageReadEntity.fromJson(data);

      if (kDebugMode) {
        print('📖 Message read by ${readEntity.userId} in chat ${readEntity.chatId}');
        print('   Last read message: ${readEntity.lastReadMessageId}');
      }

      final chatId = readEntity.chatId;
      ref.read(messageReadStatusProvider(chatId).notifier)
          .updateReadStatus(readEntity);

      final currentChat = ref.read(selectedChatProvider);
      if (currentChat?.id == chatId) {
        ref.read(messageProvider.notifier).handleMessageReadEvent(data);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error handling message_read event: $e');
        print(stackTrace);
      }
    }
  }

  void _handleMessageAllRead(Map<String, dynamic> data) {
    try {
      final readEntity = MessageReadAllEntity.fromJson(data);
      final chatId = readEntity.chatId;
      final currentChat = ref.read(selectedChatProvider);

      if (kDebugMode) {
        print('All messages read in chat ${readEntity.chatId} by user ${readEntity.userId}');
      }

      if (currentChat?.id == chatId) {
        ref.read(messageProvider.notifier).handleMessageReadAllEvent(data);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error handling message_read_all event: $e');
        print(stackTrace);
      }
    }
  }

  Future<void> connect() async {
    _isManuallyDisconnecting = false;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    if (state is _Connecting || state is _Connected) {
      return;
    }

    state = const WebSocketState.connecting();

    try {
      await _repository.connect();
    } catch (error) {
      if (kDebugMode) {
        print('WebSocket connection error: $error');
      }
      final exception = ErrorHandler.handleError(error);
      state = WebSocketState.error(error: exception.message);
      _scheduleReconnect();
    }
  }

  Future<void> disconnect() async {
    _isManuallyDisconnecting = true;
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    if (state is _Disconnected || state is _Disconnecting) {
      return;
    }

    state = const WebSocketState.disconnecting();

    try {
      await _repository.disconnect();
      state = const WebSocketState.disconnected();
    } catch (error, stackTrace) {
      state = WebSocketState.error(error: error.toString());
    } finally {
      _eventSubscription?.cancel();
      _eventSubscription = null;
    }
  }

  void sendTypingStart(String chatId) {
    if (state is _Connected) {
      _repository.sendTypingStart(chatId);
    }
  }

  void sendTypingStop(String chatId) {
    if (state is _Connected) {
      _repository.sendTypingStop(chatId);
    }
  }

  void sendMessageRead(String chatId, String messageId) {
    if (state is _Connected) {
      _repository.sendMessageRead(chatId, messageId);
    }
  }

  void sendMessageAllRead(String chatId) {
    if (state is _Connected) {
      _repository.sendMessageAllRead(chatId);
    }
  }

  bool get isConnected => state is _Connected;
  bool get isConnecting => state is _Connecting;
  bool get isDisconnected => state is _Disconnected;
  bool get hasError => state is _Error;
  String? get error => state is _Error ? (state as _Error).error : null;
}

@riverpod
bool isWebSocketConnected(ref) {
  final state = ref.watch(webSocketProvider);

  return state is _Connected;
}

@riverpod
Future<void> autoConnectWebSocket(ref) async {
  final notifier = ref.read(webSocketProvider.notifier);

  try {
    final isAuthenticated = ref.read(authProvider).isAuthenticated;

    if (isAuthenticated) {
      await Future.delayed(const Duration(seconds: 2));

      final state = ref.read(webSocketProvider);
      if (state is! _Connected && state is! _Connecting) {
        await notifier.connect();
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('⚠️ autoConnectWebSocket error: $e');
    }
  }
}

