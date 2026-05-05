// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageEntity {
  String get id;
  String get chatId;
  String get senderId;
  String get messageText;
  String get messageType;
  String? get replyToMessageId;
  MessageEntity? get replyToMessage;
  bool get isEdited;
  bool get isDeleted;
  bool get isRead;
  DateTime get createdAt;
  DateTime? get readAt;
  String get senderName;
  String get senderSurname;
  String get senderNickname;
  String? get senderAvatarUrl;
  MessageStatus get status;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      _$MessageEntityCopyWithImpl<MessageEntity>(
          this as MessageEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderSurname, senderSurname) ||
                other.senderSurname == senderSurname) &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      senderId,
      messageText,
      messageType,
      replyToMessageId,
      replyToMessage,
      isEdited,
      isDeleted,
      isRead,
      createdAt,
      readAt,
      senderName,
      senderSurname,
      senderNickname,
      senderAvatarUrl,
      status);

  @override
  String toString() {
    return 'MessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, isEdited: $isEdited, isDeleted: $isDeleted, isRead: $isRead, createdAt: $createdAt, readAt: $readAt, senderName: $senderName, senderSurname: $senderSurname, senderNickname: $senderNickname, senderAvatarUrl: $senderAvatarUrl, status: $status)';
  }
}

/// @nodoc
abstract mixin class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) _then) =
      _$MessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      String? replyToMessageId,
      MessageEntity? replyToMessage,
      bool isEdited,
      bool isDeleted,
      bool isRead,
      DateTime createdAt,
      DateTime? readAt,
      String senderName,
      String senderSurname,
      String senderNickname,
      String? senderAvatarUrl,
      MessageStatus status});

  $MessageEntityCopyWith<$Res>? get replyToMessage;
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._self, this._then);

  final MessageEntity _self;
  final $Res Function(MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? replyToMessageId = freezed,
    Object? replyToMessage = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? isRead = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? senderName = null,
    Object? senderSurname = null,
    Object? senderNickname = null,
    Object? senderAvatarUrl = freezed,
    Object? status = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _self.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      replyToMessageId: freezed == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToMessage: freezed == replyToMessage
          ? _self.replyToMessage
          : replyToMessage // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderSurname: null == senderSurname
          ? _self.senderSurname
          : senderSurname // ignore: cast_nullable_to_non_nullable
              as String,
      senderNickname: null == senderNickname
          ? _self.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatarUrl: freezed == senderAvatarUrl
          ? _self.senderAvatarUrl
          : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
    ));
  }

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
      return null;
    }

    return $MessageEntityCopyWith<$Res>(_self.replyToMessage!, (value) {
      return _then(_self.copyWith(replyToMessage: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MessageEntity].
extension MessageEntityPatterns on MessageEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_MessageEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_MessageEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_MessageEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String chatId,
            String senderId,
            String messageText,
            String messageType,
            String? replyToMessageId,
            MessageEntity? replyToMessage,
            bool isEdited,
            bool isDeleted,
            bool isRead,
            DateTime createdAt,
            DateTime? readAt,
            String senderName,
            String senderSurname,
            String senderNickname,
            String? senderAvatarUrl,
            MessageStatus status)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageEntity() when $default != null:
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.replyToMessage,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.senderName,
            _that.senderSurname,
            _that.senderNickname,
            _that.senderAvatarUrl,
            _that.status);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String chatId,
            String senderId,
            String messageText,
            String messageType,
            String? replyToMessageId,
            MessageEntity? replyToMessage,
            bool isEdited,
            bool isDeleted,
            bool isRead,
            DateTime createdAt,
            DateTime? readAt,
            String senderName,
            String senderSurname,
            String senderNickname,
            String? senderAvatarUrl,
            MessageStatus status)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageEntity():
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.replyToMessage,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.senderName,
            _that.senderSurname,
            _that.senderNickname,
            _that.senderAvatarUrl,
            _that.status);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String chatId,
            String senderId,
            String messageText,
            String messageType,
            String? replyToMessageId,
            MessageEntity? replyToMessage,
            bool isEdited,
            bool isDeleted,
            bool isRead,
            DateTime createdAt,
            DateTime? readAt,
            String senderName,
            String senderSurname,
            String senderNickname,
            String? senderAvatarUrl,
            MessageStatus status)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageEntity() when $default != null:
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.replyToMessage,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.senderName,
            _that.senderSurname,
            _that.senderNickname,
            _that.senderAvatarUrl,
            _that.status);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MessageEntity extends MessageEntity {
  const _MessageEntity(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.messageText,
      required this.messageType,
      required this.replyToMessageId,
      this.replyToMessage,
      required this.isEdited,
      required this.isDeleted,
      required this.isRead,
      required this.createdAt,
      required this.readAt,
      required this.senderName,
      required this.senderSurname,
      required this.senderNickname,
      required this.senderAvatarUrl,
      this.status = MessageStatus.none})
      : super._();

  @override
  final String id;
  @override
  final String chatId;
  @override
  final String senderId;
  @override
  final String messageText;
  @override
  final String messageType;
  @override
  final String? replyToMessageId;
  @override
  final MessageEntity? replyToMessage;
  @override
  final bool isEdited;
  @override
  final bool isDeleted;
  @override
  final bool isRead;
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
  @override
  final String senderName;
  @override
  final String senderSurname;
  @override
  final String senderNickname;
  @override
  final String? senderAvatarUrl;
  @override
  @JsonKey()
  final MessageStatus status;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageEntityCopyWith<_MessageEntity> get copyWith =>
      __$MessageEntityCopyWithImpl<_MessageEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderSurname, senderSurname) ||
                other.senderSurname == senderSurname) &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl) &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      senderId,
      messageText,
      messageType,
      replyToMessageId,
      replyToMessage,
      isEdited,
      isDeleted,
      isRead,
      createdAt,
      readAt,
      senderName,
      senderSurname,
      senderNickname,
      senderAvatarUrl,
      status);

  @override
  String toString() {
    return 'MessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, replyToMessage: $replyToMessage, isEdited: $isEdited, isDeleted: $isDeleted, isRead: $isRead, createdAt: $createdAt, readAt: $readAt, senderName: $senderName, senderSurname: $senderSurname, senderNickname: $senderNickname, senderAvatarUrl: $senderAvatarUrl, status: $status)';
  }
}

/// @nodoc
abstract mixin class _$MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$MessageEntityCopyWith(
          _MessageEntity value, $Res Function(_MessageEntity) _then) =
      __$MessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      String? replyToMessageId,
      MessageEntity? replyToMessage,
      bool isEdited,
      bool isDeleted,
      bool isRead,
      DateTime createdAt,
      DateTime? readAt,
      String senderName,
      String senderSurname,
      String senderNickname,
      String? senderAvatarUrl,
      MessageStatus status});

  @override
  $MessageEntityCopyWith<$Res>? get replyToMessage;
}

/// @nodoc
class __$MessageEntityCopyWithImpl<$Res>
    implements _$MessageEntityCopyWith<$Res> {
  __$MessageEntityCopyWithImpl(this._self, this._then);

  final _MessageEntity _self;
  final $Res Function(_MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? replyToMessageId = freezed,
    Object? replyToMessage = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? isRead = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? senderName = null,
    Object? senderSurname = null,
    Object? senderNickname = null,
    Object? senderAvatarUrl = freezed,
    Object? status = null,
  }) {
    return _then(_MessageEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _self.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      replyToMessageId: freezed == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToMessage: freezed == replyToMessage
          ? _self.replyToMessage
          : replyToMessage // ignore: cast_nullable_to_non_nullable
              as MessageEntity?,
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderSurname: null == senderSurname
          ? _self.senderSurname
          : senderSurname // ignore: cast_nullable_to_non_nullable
              as String,
      senderNickname: null == senderNickname
          ? _self.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatarUrl: freezed == senderAvatarUrl
          ? _self.senderAvatarUrl
          : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as MessageStatus,
    ));
  }

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
      return null;
    }

    return $MessageEntityCopyWith<$Res>(_self.replyToMessage!, (value) {
      return _then(_self.copyWith(replyToMessage: value));
    });
  }
}

// dart format on
