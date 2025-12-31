// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isWebSocketConnectedHash() =>
    r'eca40270265bc8bbb1801eecefccf4c4ee3dc0be';

/// See also [isWebSocketConnected].
@ProviderFor(isWebSocketConnected)
final isWebSocketConnectedProvider = AutoDisposeProvider<bool>.internal(
  isWebSocketConnected,
  name: r'isWebSocketConnectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isWebSocketConnectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsWebSocketConnectedRef = AutoDisposeProviderRef<bool>;
String _$autoConnectWebSocketHash() =>
    r'aab0ce69728dc736f313478ae961175a1bca4899';

/// See also [autoConnectWebSocket].
@ProviderFor(autoConnectWebSocket)
final autoConnectWebSocketProvider = AutoDisposeFutureProvider<void>.internal(
  autoConnectWebSocket,
  name: r'autoConnectWebSocketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$autoConnectWebSocketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AutoConnectWebSocketRef = AutoDisposeFutureProviderRef<void>;
String _$webSocketNotifierHash() => r'83dc4315971f8b6802e8e119d4b50efb96aec179';

/// See also [WebSocketNotifier].
@ProviderFor(WebSocketNotifier)
final webSocketNotifierProvider =
    AutoDisposeNotifierProvider<WebSocketNotifier, WebSocketState>.internal(
  WebSocketNotifier.new,
  name: r'webSocketNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$webSocketNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WebSocketNotifier = AutoDisposeNotifier<WebSocketState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
