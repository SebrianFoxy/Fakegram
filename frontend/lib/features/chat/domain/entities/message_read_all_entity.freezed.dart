// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_read_all_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageReadAllEntity {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'read_at')
  DateTime get readAt;

  /// Create a copy of MessageReadAllEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageReadAllEntityCopyWith<MessageReadAllEntity> get copyWith =>
      _$MessageReadAllEntityCopyWithImpl<MessageReadAllEntity>(
          this as MessageReadAllEntity, _$identity);

  /// Serializes this MessageReadAllEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageReadAllEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, chatId, readAt);

  @override
  String toString() {
    return 'MessageReadAllEntity(userId: $userId, chatId: $chatId, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageReadAllEntityCopyWith<$Res> {
  factory $MessageReadAllEntityCopyWith(MessageReadAllEntity value,
          $Res Function(MessageReadAllEntity) _then) =
      _$MessageReadAllEntityCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class _$MessageReadAllEntityCopyWithImpl<$Res>
    implements $MessageReadAllEntityCopyWith<$Res> {
  _$MessageReadAllEntityCopyWithImpl(this._self, this._then);

  final MessageReadAllEntity _self;
  final $Res Function(MessageReadAllEntity) _then;

  /// Create a copy of MessageReadAllEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? chatId = null,
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
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageReadAllEntity].
extension MessageReadAllEntityPatterns on MessageReadAllEntity {
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
    TResult Function(_MessageReadAllEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity() when $default != null:
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
    TResult Function(_MessageReadAllEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity():
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
    TResult? Function(_MessageReadAllEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity() when $default != null:
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
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity() when $default != null:
        return $default(_that.userId, _that.chatId, _that.readAt);
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
            @JsonKey(name: 'read_at') DateTime readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity():
        return $default(_that.userId, _that.chatId, _that.readAt);
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
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadAllEntity() when $default != null:
        return $default(_that.userId, _that.chatId, _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageReadAllEntity implements MessageReadAllEntity {
  const _MessageReadAllEntity(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'read_at') required this.readAt});
  factory _MessageReadAllEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadAllEntityFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'read_at')
  final DateTime readAt;

  /// Create a copy of MessageReadAllEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReadAllEntityCopyWith<_MessageReadAllEntity> get copyWith =>
      __$MessageReadAllEntityCopyWithImpl<_MessageReadAllEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageReadAllEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReadAllEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, chatId, readAt);

  @override
  String toString() {
    return 'MessageReadAllEntity(userId: $userId, chatId: $chatId, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageReadAllEntityCopyWith<$Res>
    implements $MessageReadAllEntityCopyWith<$Res> {
  factory _$MessageReadAllEntityCopyWith(_MessageReadAllEntity value,
          $Res Function(_MessageReadAllEntity) _then) =
      __$MessageReadAllEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class __$MessageReadAllEntityCopyWithImpl<$Res>
    implements _$MessageReadAllEntityCopyWith<$Res> {
  __$MessageReadAllEntityCopyWithImpl(this._self, this._then);

  final _MessageReadAllEntity _self;
  final $Res Function(_MessageReadAllEntity) _then;

  /// Create a copy of MessageReadAllEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? chatId = null,
    Object? readAt = null,
  }) {
    return _then(_MessageReadAllEntity(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
