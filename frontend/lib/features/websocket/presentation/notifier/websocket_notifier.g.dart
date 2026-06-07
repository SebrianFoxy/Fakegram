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

String _$webSocketNotifierHash() => r'e2fcf57b41ffd0829b329542288a5652e4f5f646';

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

@ProviderFor(webSocketRepository)
const webSocketRepositoryProvider = WebSocketRepositoryProvider._();

final class WebSocketRepositoryProvider extends $FunctionalProvider<
    WebSocketRepository,
    WebSocketRepository,
    WebSocketRepository> with $Provider<WebSocketRepository> {
  const WebSocketRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'webSocketRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$webSocketRepositoryHash();

  @$internal
  @override
  $ProviderElement<WebSocketRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WebSocketRepository create(Ref ref) {
    return webSocketRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WebSocketRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WebSocketRepository>(value),
    );
  }
}

String _$webSocketRepositoryHash() =>
    r'4a19c43814a92cac6bf4d24e9ec190b4fec89db2';

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
    r'510ad5d41364b47c3e1bad3a315eb287bcbc61a7';

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
    r'0409fea846b28d065270ef632790a43229cbf17e';
