// presenter/websocket/notifier/websocket_notifier.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fakegram/data/secure_storage/secure_storage.dart';

import '../../../data/models/websocket/websocket_event/websocket_event_model.dart';
import '../../../services/websocket/websocket_service.dart';
import '../../auth/notifier/auth_notifier.dart';
import '../providers/websocket_providers.dart';

final webSocketServiceProvider = Provider<WebSocketService>((ref) {
  final authNotifier = ref.read(authNotifierProvider.notifier);
  return WebSocketService(authNotifier);
});

final webSocketNotifierProvider = StateNotifierProvider<WebSocketNotifier, bool>((ref) {
  final service = ref.watch(webSocketServiceProvider);
  return WebSocketNotifier(service, ref);
});

class WebSocketNotifier extends StateNotifier<bool> {
  final WebSocketService _service;
  final Ref _ref;

  WebSocketNotifier(this._service, this._ref) : super(false) {
    _setupListeners();
  }

  void _setupListeners() {
    _service.onEvent = _handleEvent;
    _service.onError = _handleError;
    _service.onConnected = _handleConnected;
    _service.onDisconnected = _handleDisconnected;
  }

  Future<void> connect() async {
    final token = await SecureStorage().readSecureData('accessToken');
    if (token != null) {
      const baseUrl = 'ws://localhost:8080';
      await _service.connect('$baseUrl/api/v1/ws', token);
    }
  }

  void disconnect() {
    _service.disconnect();
  }

  void sendTypingStart(String chatId) {
    _service.sendTypingStart(chatId);
  }

  void sendTypingStop(String chatId) {
    _service.sendTypingStop(chatId);
  }

  void sendMessageRead(String chatId, String maxId) {
    _service.sendMessageRead(chatId, maxId);
  }

  void _handleEvent(WebSocketEvent event) {
    switch (event.data["event"]) {
      case 'chat_list_update':
        debugPrint("CHATLISTUPDATE ACTIVATE: ${event.data["data"]}");
        _handleChatListUpdate(event.data["data"]);
        break;
      case 'new_chat_created':
        _handleNewChatCreated(event.data["data"]);
        break;
      case 'message_sent':
        _handleMessageSent(event.data["data"]);
        break;
      case 'message_read':
        _handleMessageRead(event.data["data"]);
        break;
      case 'user_typing':
        _handleUserTyping(event.data["data"]);
        break;
      case 'user_online':
        _handleUserOnline(event.data["data"]);
        break;
      case 'user_offline':
        _handleUserOffline(event.data["data"]);
        break;
    }
  }

  void _handleChatListUpdate(Map<String, dynamic> data) {
    _ref.read(chatUpdateProvider.notifier).state = data;
  }

  void _handleNewChatCreated(Map<String, dynamic> data) {
    _ref.read(newChatProvider.notifier).state = data;
  }

  void _handleMessageSent(Map<String, dynamic> data) {
    _ref.read(newMessageProvider.notifier).state = data;
  }

  void _handleMessageRead(Map<String, dynamic> data) {
    _ref.read(messageReadProvider.notifier).state = data;
  }

  void _handleUserTyping(Map<String, dynamic> data) {
    _ref.read(typingStatusProvider.notifier).state = data;
  }

  void _handleUserOnline(Map<String, dynamic> data) {
    _ref.read(userOnlineStatusProvider.notifier).state = data;
  }

  void _handleUserOffline(Map<String, dynamic> data) {
    _ref.read(userOnlineStatusProvider.notifier).state = data;
  }

  void _handleError(String error) {
    print('WebSocket error: $error');
  }

  void _handleConnected() {
    state = true;
  }

  void _handleDisconnected() {
    state = false;
    Future.delayed(const Duration(seconds: 5), () {
      if (!state) connect();
    });
  }
}