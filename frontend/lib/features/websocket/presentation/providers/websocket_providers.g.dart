// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'websocket_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$chatUpdateHash() => r'563efaf6c44eb0976d191c06f4167eb9fe2cb55b';

/// See also [ChatUpdate].
@ProviderFor(ChatUpdate)
final chatUpdateProvider =
    AutoDisposeNotifierProvider<ChatUpdate, Map<String, dynamic>?>.internal(
  ChatUpdate.new,
  name: r'chatUpdateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$chatUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ChatUpdate = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$newChatHash() => r'6414febe2dd79ec88f2be6a5dc69c1585fd48fdc';

/// See also [NewChat].
@ProviderFor(NewChat)
final newChatProvider =
    AutoDisposeNotifierProvider<NewChat, Map<String, dynamic>?>.internal(
  NewChat.new,
  name: r'newChatProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$newChatHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewChat = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$newMessageHash() => r'ef2de59f5d90c2ad12b7f24942cffdac172783f0';

/// See also [NewMessage].
@ProviderFor(NewMessage)
final newMessageProvider =
    AutoDisposeNotifierProvider<NewMessage, Map<String, dynamic>?>.internal(
  NewMessage.new,
  name: r'newMessageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$newMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewMessage = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$newMessageFromSocketHash() =>
    r'19b9729d145272303efd012931473190a6d7e455';

/// See also [NewMessageFromSocket].
@ProviderFor(NewMessageFromSocket)
final newMessageFromSocketProvider = AutoDisposeNotifierProvider<
    NewMessageFromSocket, Map<String, dynamic>?>.internal(
  NewMessageFromSocket.new,
  name: r'newMessageFromSocketProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$newMessageFromSocketHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$NewMessageFromSocket = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$messageSentConfirmationHash() =>
    r'8f73f5bd218614211e02b0809437b5de2e964307';

/// See also [MessageSentConfirmation].
@ProviderFor(MessageSentConfirmation)
final messageSentConfirmationProvider = AutoDisposeNotifierProvider<
    MessageSentConfirmation, Map<String, dynamic>?>.internal(
  MessageSentConfirmation.new,
  name: r'messageSentConfirmationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageSentConfirmationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageSentConfirmation = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$messageStatusUpdateHash() =>
    r'6935d758a081fcc9f9157114be3c53a3ba1da732';

/// See also [MessageStatusUpdate].
@ProviderFor(MessageStatusUpdate)
final messageStatusUpdateProvider = AutoDisposeNotifierProvider<
    MessageStatusUpdate, Map<String, dynamic>?>.internal(
  MessageStatusUpdate.new,
  name: r'messageStatusUpdateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageStatusUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageStatusUpdate = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$messageDeletedHash() => r'fe5368b139faeb4d58f2224262b0b5b162885f8c';

/// See also [MessageDeleted].
@ProviderFor(MessageDeleted)
final messageDeletedProvider =
    AutoDisposeNotifierProvider<MessageDeleted, Map<String, dynamic>?>.internal(
  MessageDeleted.new,
  name: r'messageDeletedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$messageDeletedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageDeleted = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$messageReadHash() => r'46f5a467b4870be1ef13b529798f5f6165e0cb76';

/// See also [MessageRead].
@ProviderFor(MessageRead)
final messageReadProvider =
    AutoDisposeNotifierProvider<MessageRead, Map<String, dynamic>?>.internal(
  MessageRead.new,
  name: r'messageReadProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messageReadHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MessageRead = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$messageReadStatusHash() => r'383257e2acf431762c867257f67f8b4eadd9c404';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MessageReadStatus
    extends BuildlessAutoDisposeNotifier<Map<String, DateTime>?> {
  late final String chatId;

  Map<String, DateTime>? build(
    String chatId,
  );
}

/// See also [MessageReadStatus].
@ProviderFor(MessageReadStatus)
const messageReadStatusProvider = MessageReadStatusFamily();

/// See also [MessageReadStatus].
class MessageReadStatusFamily extends Family<Map<String, DateTime>?> {
  /// See also [MessageReadStatus].
  const MessageReadStatusFamily();

  /// See also [MessageReadStatus].
  MessageReadStatusProvider call(
    String chatId,
  ) {
    return MessageReadStatusProvider(
      chatId,
    );
  }

  @override
  MessageReadStatusProvider getProviderOverride(
    covariant MessageReadStatusProvider provider,
  ) {
    return call(
      provider.chatId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'messageReadStatusProvider';
}

/// See also [MessageReadStatus].
class MessageReadStatusProvider extends AutoDisposeNotifierProviderImpl<
    MessageReadStatus, Map<String, DateTime>?> {
  /// See also [MessageReadStatus].
  MessageReadStatusProvider(
    String chatId,
  ) : this._internal(
          () => MessageReadStatus()..chatId = chatId,
          from: messageReadStatusProvider,
          name: r'messageReadStatusProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$messageReadStatusHash,
          dependencies: MessageReadStatusFamily._dependencies,
          allTransitiveDependencies:
              MessageReadStatusFamily._allTransitiveDependencies,
          chatId: chatId,
        );

  MessageReadStatusProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.chatId,
  }) : super.internal();

  final String chatId;

  @override
  Map<String, DateTime>? runNotifierBuild(
    covariant MessageReadStatus notifier,
  ) {
    return notifier.build(
      chatId,
    );
  }

  @override
  Override overrideWith(MessageReadStatus Function() create) {
    return ProviderOverride(
      origin: this,
      override: MessageReadStatusProvider._internal(
        () => create()..chatId = chatId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        chatId: chatId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MessageReadStatus, Map<String, DateTime>?>
      createElement() {
    return _MessageReadStatusProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MessageReadStatusProvider && other.chatId == chatId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, chatId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MessageReadStatusRef
    on AutoDisposeNotifierProviderRef<Map<String, DateTime>?> {
  /// The parameter `chatId` of this provider.
  String get chatId;
}

class _MessageReadStatusProviderElement
    extends AutoDisposeNotifierProviderElement<MessageReadStatus,
        Map<String, DateTime>?> with MessageReadStatusRef {
  _MessageReadStatusProviderElement(super.provider);

  @override
  String get chatId => (origin as MessageReadStatusProvider).chatId;
}

String _$typingStatusHash() => r'ff0cfefafea8881290d4cd9ff41347700df00442';

/// See also [TypingStatus].
@ProviderFor(TypingStatus)
final typingStatusProvider =
    AutoDisposeNotifierProvider<TypingStatus, Map<String, dynamic>?>.internal(
  TypingStatus.new,
  name: r'typingStatusProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$typingStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TypingStatus = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$userOnlineStatusHash() => r'531ae584ca68238d99adf6480b41ca1cd93ec4e9';

/// See also [UserOnlineStatus].
@ProviderFor(UserOnlineStatus)
final userOnlineStatusProvider = AutoDisposeNotifierProvider<UserOnlineStatus,
    Map<String, dynamic>?>.internal(
  UserOnlineStatus.new,
  name: r'userOnlineStatusProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userOnlineStatusHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserOnlineStatus = AutoDisposeNotifier<Map<String, dynamic>?>;
String _$unreadCountUpdateHash() => r'3bb4e0387800e6751cc8d62de77770f1f3ec5815';

/// See also [UnreadCountUpdate].
@ProviderFor(UnreadCountUpdate)
final unreadCountUpdateProvider = AutoDisposeNotifierProvider<UnreadCountUpdate,
    Map<String, dynamic>?>.internal(
  UnreadCountUpdate.new,
  name: r'unreadCountUpdateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$unreadCountUpdateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UnreadCountUpdate = AutoDisposeNotifier<Map<String, dynamic>?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
