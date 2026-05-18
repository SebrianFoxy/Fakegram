// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MessageNotifier)
const messageProvider = MessageNotifierProvider._();

final class MessageNotifierProvider
    extends $NotifierProvider<MessageNotifier, MessageState> {
  const MessageNotifierProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageNotifierHash();

  @$internal
  @override
  MessageNotifier create() => MessageNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MessageState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MessageState>(value),
    );
  }
}

String _$messageNotifierHash() => r'047eb89affc8ea5728866bfdcbe19d63ab5b613c';

abstract class _$MessageNotifier extends $Notifier<MessageState> {
  MessageState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<MessageState, MessageState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<MessageState, MessageState>,
        MessageState,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
