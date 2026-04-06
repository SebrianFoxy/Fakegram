// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatUpdate)
const chatUpdateProvider = ChatUpdateProvider._();

final class ChatUpdateProvider
    extends $NotifierProvider<ChatUpdate, Map<String, dynamic>?> {
  const ChatUpdateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'chatUpdateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$chatUpdateHash();

  @$internal
  @override
  ChatUpdate create() => ChatUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$chatUpdateHash() => r'563efaf6c44eb0976d191c06f4167eb9fe2cb55b';

abstract class _$ChatUpdate extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(NewChat)
const newChatProvider = NewChatProvider._();

final class NewChatProvider
    extends $NotifierProvider<NewChat, Map<String, dynamic>?> {
  const NewChatProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newChatProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newChatHash();

  @$internal
  @override
  NewChat create() => NewChat();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$newChatHash() => r'6414febe2dd79ec88f2be6a5dc69c1585fd48fdc';

abstract class _$NewChat extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(NewMessage)
const newMessageProvider = NewMessageProvider._();

final class NewMessageProvider
    extends $NotifierProvider<NewMessage, Map<String, dynamic>?> {
  const NewMessageProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newMessageProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newMessageHash();

  @$internal
  @override
  NewMessage create() => NewMessage();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$newMessageHash() => r'ef2de59f5d90c2ad12b7f24942cffdac172783f0';

abstract class _$NewMessage extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(NewMessageFromSocket)
const newMessageFromSocketProvider = NewMessageFromSocketProvider._();

final class NewMessageFromSocketProvider
    extends $NotifierProvider<NewMessageFromSocket, Map<String, dynamic>?> {
  const NewMessageFromSocketProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'newMessageFromSocketProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$newMessageFromSocketHash();

  @$internal
  @override
  NewMessageFromSocket create() => NewMessageFromSocket();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$newMessageFromSocketHash() =>
    r'19b9729d145272303efd012931473190a6d7e455';

abstract class _$NewMessageFromSocket extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MessageSentConfirmation)
const messageSentConfirmationProvider = MessageSentConfirmationProvider._();

final class MessageSentConfirmationProvider
    extends $NotifierProvider<MessageSentConfirmation, Map<String, dynamic>?> {
  const MessageSentConfirmationProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageSentConfirmationProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageSentConfirmationHash();

  @$internal
  @override
  MessageSentConfirmation create() => MessageSentConfirmation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$messageSentConfirmationHash() =>
    r'8f73f5bd218614211e02b0809437b5de2e964307';

abstract class _$MessageSentConfirmation
    extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MessageStatusUpdate)
const messageStatusUpdateProvider = MessageStatusUpdateProvider._();

final class MessageStatusUpdateProvider
    extends $NotifierProvider<MessageStatusUpdate, Map<String, dynamic>?> {
  const MessageStatusUpdateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageStatusUpdateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageStatusUpdateHash();

  @$internal
  @override
  MessageStatusUpdate create() => MessageStatusUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$messageStatusUpdateHash() =>
    r'6935d758a081fcc9f9157114be3c53a3ba1da732';

abstract class _$MessageStatusUpdate extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MessageDeleted)
const messageDeletedProvider = MessageDeletedProvider._();

final class MessageDeletedProvider
    extends $NotifierProvider<MessageDeleted, Map<String, dynamic>?> {
  const MessageDeletedProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageDeletedProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageDeletedHash();

  @$internal
  @override
  MessageDeleted create() => MessageDeleted();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$messageDeletedHash() => r'fe5368b139faeb4d58f2224262b0b5b162885f8c';

abstract class _$MessageDeleted extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MessageRead)
const messageReadProvider = MessageReadProvider._();

final class MessageReadProvider
    extends $NotifierProvider<MessageRead, Map<String, dynamic>?> {
  const MessageReadProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'messageReadProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageReadHash();

  @$internal
  @override
  MessageRead create() => MessageRead();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$messageReadHash() => r'46f5a467b4870be1ef13b529798f5f6165e0cb76';

abstract class _$MessageRead extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(MessageReadStatus)
const messageReadStatusProvider = MessageReadStatusFamily._();

final class MessageReadStatusProvider
    extends $NotifierProvider<MessageReadStatus, Map<String, DateTime>?> {
  const MessageReadStatusProvider._(
      {required MessageReadStatusFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'messageReadStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$messageReadStatusHash();

  @override
  String toString() {
    return r'messageReadStatusProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MessageReadStatus create() => MessageReadStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, DateTime>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, DateTime>?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MessageReadStatusProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$messageReadStatusHash() => r'383257e2acf431762c867257f67f8b4eadd9c404';

final class MessageReadStatusFamily extends $Family
    with
        $ClassFamilyOverride<MessageReadStatus, Map<String, DateTime>?,
            Map<String, DateTime>?, Map<String, DateTime>?, String> {
  const MessageReadStatusFamily._()
      : super(
          retry: null,
          name: r'messageReadStatusProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  MessageReadStatusProvider call(
    String chatId,
  ) =>
      MessageReadStatusProvider._(argument: chatId, from: this);

  @override
  String toString() => r'messageReadStatusProvider';
}

abstract class _$MessageReadStatus extends $Notifier<Map<String, DateTime>?> {
  late final _$args = ref.$arg as String;
  String get chatId => _$args;

  Map<String, DateTime>? build(
    String chatId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(
      _$args,
    );
    final ref =
        this.ref as $Ref<Map<String, DateTime>?, Map<String, DateTime>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, DateTime>?, Map<String, DateTime>?>,
        Map<String, DateTime>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(TypingStatus)
const typingStatusProvider = TypingStatusProvider._();

final class TypingStatusProvider
    extends $NotifierProvider<TypingStatus, Map<String, dynamic>?> {
  const TypingStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'typingStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$typingStatusHash();

  @$internal
  @override
  TypingStatus create() => TypingStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$typingStatusHash() => r'ff0cfefafea8881290d4cd9ff41347700df00442';

abstract class _$TypingStatus extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UserOnlineStatus)
const userOnlineStatusProvider = UserOnlineStatusProvider._();

final class UserOnlineStatusProvider
    extends $NotifierProvider<UserOnlineStatus, Map<String, dynamic>?> {
  const UserOnlineStatusProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'userOnlineStatusProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userOnlineStatusHash();

  @$internal
  @override
  UserOnlineStatus create() => UserOnlineStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$userOnlineStatusHash() => r'531ae584ca68238d99adf6480b41ca1cd93ec4e9';

abstract class _$UserOnlineStatus extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

@ProviderFor(UnreadCountUpdate)
const unreadCountUpdateProvider = UnreadCountUpdateProvider._();

final class UnreadCountUpdateProvider
    extends $NotifierProvider<UnreadCountUpdate, Map<String, dynamic>?> {
  const UnreadCountUpdateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'unreadCountUpdateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$unreadCountUpdateHash();

  @$internal
  @override
  UnreadCountUpdate create() => UnreadCountUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, dynamic>? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, dynamic>?>(value),
    );
  }
}

String _$unreadCountUpdateHash() => r'3bb4e0387800e6751cc8d62de77770f1f3ec5815';

abstract class _$UnreadCountUpdate extends $Notifier<Map<String, dynamic>?> {
  Map<String, dynamic>? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Map<String, dynamic>?, Map<String, dynamic>?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Map<String, dynamic>?, Map<String, dynamic>?>,
        Map<String, dynamic>?,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}
