// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_read_info_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageReadInfoEntity {
  @JsonKey(name: 'user_id')
  String get userId;
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'surname')
  String get surname;
  @JsonKey(name: 'nickname')
  String get nickname;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @JsonKey(name: 'read_at')
  DateTime get readAt;

  /// Create a copy of MessageReadInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageReadInfoEntityCopyWith<MessageReadInfoEntity> get copyWith =>
      _$MessageReadInfoEntityCopyWithImpl<MessageReadInfoEntity>(
          this as MessageReadInfoEntity, _$identity);

  /// Serializes this MessageReadInfoEntity to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageReadInfoEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, name, surname, nickname, avatarUrl, readAt);

  @override
  String toString() {
    return 'MessageReadInfoEntity(userId: $userId, name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageReadInfoEntityCopyWith<$Res> {
  factory $MessageReadInfoEntityCopyWith(MessageReadInfoEntity value,
          $Res Function(MessageReadInfoEntity) _then) =
      _$MessageReadInfoEntityCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class _$MessageReadInfoEntityCopyWithImpl<$Res>
    implements $MessageReadInfoEntityCopyWith<$Res> {
  _$MessageReadInfoEntityCopyWithImpl(this._self, this._then);

  final MessageReadInfoEntity _self;
  final $Res Function(MessageReadInfoEntity) _then;

  /// Create a copy of MessageReadInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
    Object? readAt = null,
  }) {
    return _then(_self.copyWith(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageReadInfoEntity].
extension MessageReadInfoEntityPatterns on MessageReadInfoEntity {
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
    TResult Function(_MessageReadInfoEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity() when $default != null:
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
    TResult Function(_MessageReadInfoEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity():
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
    TResult? Function(_MessageReadInfoEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity() when $default != null:
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
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'surname') String surname,
            @JsonKey(name: 'nickname') String nickname,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity() when $default != null:
        return $default(_that.userId, _that.name, _that.surname, _that.nickname,
            _that.avatarUrl, _that.readAt);
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
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'surname') String surname,
            @JsonKey(name: 'nickname') String nickname,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'read_at') DateTime readAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity():
        return $default(_that.userId, _that.name, _that.surname, _that.nickname,
            _that.avatarUrl, _that.readAt);
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
            @JsonKey(name: 'name') String name,
            @JsonKey(name: 'surname') String surname,
            @JsonKey(name: 'nickname') String nickname,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'read_at') DateTime readAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoEntity() when $default != null:
        return $default(_that.userId, _that.name, _that.surname, _that.nickname,
            _that.avatarUrl, _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageReadInfoEntity implements MessageReadInfoEntity {
  const _MessageReadInfoEntity(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'surname') this.surname = '',
      @JsonKey(name: 'nickname') this.nickname = '',
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'read_at') required this.readAt});
  factory _MessageReadInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadInfoEntityFromJson(json);

  @override
  @JsonKey(name: 'user_id')
  final String userId;
  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'surname')
  final String surname;
  @override
  @JsonKey(name: 'nickname')
  final String nickname;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'read_at')
  final DateTime readAt;

  /// Create a copy of MessageReadInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReadInfoEntityCopyWith<_MessageReadInfoEntity> get copyWith =>
      __$MessageReadInfoEntityCopyWithImpl<_MessageReadInfoEntity>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageReadInfoEntityToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReadInfoEntity &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.readAt, readAt) || other.readAt == readAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, name, surname, nickname, avatarUrl, readAt);

  @override
  String toString() {
    return 'MessageReadInfoEntity(userId: $userId, name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageReadInfoEntityCopyWith<$Res>
    implements $MessageReadInfoEntityCopyWith<$Res> {
  factory _$MessageReadInfoEntityCopyWith(_MessageReadInfoEntity value,
          $Res Function(_MessageReadInfoEntity) _then) =
      __$MessageReadInfoEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'user_id') String userId,
      @JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'read_at') DateTime readAt});
}

/// @nodoc
class __$MessageReadInfoEntityCopyWithImpl<$Res>
    implements _$MessageReadInfoEntityCopyWith<$Res> {
  __$MessageReadInfoEntityCopyWithImpl(this._self, this._then);

  final _MessageReadInfoEntity _self;
  final $Res Function(_MessageReadInfoEntity) _then;

  /// Create a copy of MessageReadInfoEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
    Object? readAt = null,
  }) {
    return _then(_MessageReadInfoEntity(
      userId: null == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      readAt: null == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
