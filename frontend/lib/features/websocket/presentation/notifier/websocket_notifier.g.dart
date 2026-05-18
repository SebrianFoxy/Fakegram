// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(WebSocketNotifier)
const webSocketProvider = WebSocketNotifierProvider._();

final class WebSocketNotifierProvider
    extends $NotifierProvider<WebSocketNotifier, WebSocketState> {
  const WebSocketNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSocketProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$webSocketNotifierHash();

  @$internal
  @override
  WebSocketNotifier create() => WebSocketNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketState>(value),
    );
  }
}

String _$webSocketNotifierHash() => r'092121c83eba971550d7d9ef4dea9f9cc23290d7';

abstract class _$WebSocketNotifier extends $Notifier<WebSocketState> {
  WebSocketState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<WebSocketState, WebSocketState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<WebSocketState, WebSocketState>,
        WebSocketState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(isWebSocketConnected)
const isWebSocketConnectedProvider = IsWebSocketConnectedProvider._();

final class IsWebSocketConnectedProvider
    extends $FunctionalProvider<bool, bool, bool> with $Provider<bool> {
  const IsWebSocketConnectedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isWebSocketConnectedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isWebSocketConnectedHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isWebSocketConnected(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isWebSocketConnectedHash() =>
    r'b1c59a6730b495d77658d0bc29a451c93b2cc22b';

@ProviderFor(autoConnectWebSocket)
const autoConnectWebSocketProvider = AutoConnectWebSocketProvider._();

final class AutoConnectWebSocketProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  const AutoConnectWebSocketProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'autoConnectWebSocketProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$autoConnectWebSocketHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return autoConnectWebSocket(ref);
  }
}

String _$autoConnectWebSocketHash() =>
    r'be5d54b73ac9bcffd85afa7fdf607e7519961dc7';
