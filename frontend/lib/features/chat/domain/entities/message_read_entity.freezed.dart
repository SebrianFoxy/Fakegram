// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_read_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageReadEntity {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'last_read_message_id')
  String get lastReadMessageId;
  @JsonKey(name: 'read_at')
  DateTime get readAt;

  /// Create a copy of MessageReadEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageReadEntityCopyWith<MessageReadEntity> get copyWith =>
      _$MessageReadEntityCopyWithImpl<MessageReadEntity>(
          this as MessageReadEntity, _$identity);

  /// Serializes this MessageReadEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageReadEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.lastReadMessageId, lastReadMessageId) ||
                other.lastReadMessageId == lastReadMessageId) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, chatId, lastReadMessageId, readAt);

  @override
  String toString() {
    return 'MessageReadEntity(userId: $userId, chatId: $chatId, lastReadMessageId: $lastReadMessageId, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageReadEntityCopyWith<$Res> {
  factory $MessageReadEntityCopyWith(
          MessageReadEntity value, $Res Function(MessageReadEntity) _then) =
      _$MessageReadEntityCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'last_read_message_id') String lastReadMessageId,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class _$MessageReadEntityCopyWithImpl<$Res>
    implements $MessageReadEntityCopyWith<$Res> {
  _$MessageReadEntityCopyWithImpl(this._self, this._then);

  final MessageReadEntity _self;
  final $Res Function(MessageReadEntity) _then;

  /// Create a copy of MessageReadEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? chatId = null,
    Object? lastReadMessageId = null,
    Object? readAt = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadMessageId: null == lastReadMessageId
          ? _self.lastReadMessageId
          : lastReadMessageId // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageReadEntity].
extension MessageReadEntityPatterns on MessageReadEntity {
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
    TResult Function(_MessageReadEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity() when $default != null:
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
    TResult Function(_MessageReadEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity():
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
    TResult? Function(_MessageReadEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity() when $default != null:
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'last_read_message_id') String lastReadMessageId,
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity() when $default != null:
        return $default(
            _that.userId, _that.chatId, _that.lastReadMessageId, _that.readAt);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'last_read_message_id') String lastReadMessageId,
            @JsonKey(name: 'read_at') DateTime readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity():
        return $default(
            _that.userId, _that.chatId, _that.lastReadMessageId, _that.readAt);
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
            @JsonKey(name: 'user_id') String userId,
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'last_read_message_id') String lastReadMessageId,
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadEntity() when $default != null:
        return $default(
            _that.userId, _that.chatId, _that.lastReadMessageId, _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageReadEntity implements MessageReadEntity {
  const _MessageReadEntity(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'last_read_message_id') required this.lastReadMessageId,
      @JsonKey(name: 'read_at') required this.readAt});
  factory _MessageReadEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadEntityFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'last_read_message_id')
  final String lastReadMessageId;
  @override
  @JsonKey(name: 'read_at')
  final DateTime readAt;

  /// Create a copy of MessageReadEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReadEntityCopyWith<_MessageReadEntity> get copyWith =>
      __$MessageReadEntityCopyWithImpl<_MessageReadEntity>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageReadEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReadEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.lastReadMessageId, lastReadMessageId) ||
                other.lastReadMessageId == lastReadMessageId) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, chatId, lastReadMessageId, readAt);

  @override
  String toString() {
    return 'MessageReadEntity(userId: $userId, chatId: $chatId, lastReadMessageId: $lastReadMessageId, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageReadEntityCopyWith<$Res>
    implements $MessageReadEntityCopyWith<$Res> {
  factory _$MessageReadEntityCopyWith(
          _MessageReadEntity value, $Res Function(_MessageReadEntity) _then) =
      __$MessageReadEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'last_read_message_id') String lastReadMessageId,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class __$MessageReadEntityCopyWithImpl<$Res>
    implements _$MessageReadEntityCopyWith<$Res> {
  __$MessageReadEntityCopyWithImpl(this._self, this._then);

  final _MessageReadEntity _self;
  final $Res Function(_MessageReadEntity) _then;

  /// Create a copy of MessageReadEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? chatId = null,
    Object? lastReadMessageId = null,
    Object? readAt = null,
  }) {
    return _then(_MessageReadEntity(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      lastReadMessageId: null == lastReadMessageId
          ? _self.lastReadMessageId
          : lastReadMessageId // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
