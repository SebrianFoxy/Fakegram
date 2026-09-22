// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_read_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageReadInfoModel {
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

  /// Create a copy of MessageReadInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageReadInfoModelCopyWith<MessageReadInfoModel> get copyWith =>
      _$MessageReadInfoModelCopyWithImpl<MessageReadInfoModel>(
          this as MessageReadInfoModel, _$identity);

  /// Serializes this MessageReadInfoModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageReadInfoModel &&
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
    return 'MessageReadInfoModel(userId: $userId, name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class $MessageReadInfoModelCopyWith<$Res> {
  factory $MessageReadInfoModelCopyWith(MessageReadInfoModel value,
          $Res Function(MessageReadInfoModel) _then) =
      _$MessageReadInfoModelCopyWithImpl;
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
class _$MessageReadInfoModelCopyWithImpl<$Res>
    implements $MessageReadInfoModelCopyWith<$Res> {
  _$MessageReadInfoModelCopyWithImpl(this._self, this._then);

  final MessageReadInfoModel _self;
  final $Res Function(MessageReadInfoModel) _then;

  /// Create a copy of MessageReadInfoModel
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

/// Adds pattern-matching-related methods to [MessageReadInfoModel].
extension MessageReadInfoModelPatterns on MessageReadInfoModel {
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
    TResult Function(_MessageReadInfoModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoModel() when $default != null:
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
    TResult Function(_MessageReadInfoModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoModel():
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
    TResult? Function(_MessageReadInfoModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageReadInfoModel() when $default != null:
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
      case _MessageReadInfoModel() when $default != null:
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
      case _MessageReadInfoModel():
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
      case _MessageReadInfoModel() when $default != null:
        return $default(_that.userId, _that.name, _that.surname, _that.nickname,
            _that.avatarUrl, _that.readAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageReadInfoModel extends MessageReadInfoModel {
  const _MessageReadInfoModel(
      {@JsonKey(name: 'user_id') required this.userId,
      @JsonKey(name: 'name') this.name = '',
      @JsonKey(name: 'surname') this.surname = '',
      @JsonKey(name: 'nickname') this.nickname = '',
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'read_at') required this.readAt})
      : super._();
  factory _MessageReadInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MessageReadInfoModelFromJson(json);

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

  /// Create a copy of MessageReadInfoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageReadInfoModelCopyWith<_MessageReadInfoModel> get copyWith =>
      __$MessageReadInfoModelCopyWithImpl<_MessageReadInfoModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageReadInfoModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageReadInfoModel &&
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
    return 'MessageReadInfoModel(userId: $userId, name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl, readAt: $readAt)';
  }
}

/// @nodoc
abstract mixin class _$MessageReadInfoModelCopyWith<$Res>
    implements $MessageReadInfoModelCopyWith<$Res> {
  factory _$MessageReadInfoModelCopyWith(_MessageReadInfoModel value,
          $Res Function(_MessageReadInfoModel) _then) =
      __$MessageReadInfoModelCopyWithImpl;
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
class __$MessageReadInfoModelCopyWithImpl<$Res>
    implements _$MessageReadInfoModelCopyWith<$Res> {
  __$MessageReadInfoModelCopyWithImpl(this._self, this._then);

  final _MessageReadInfoModel _self;
  final $Res Function(_MessageReadInfoModel) _then;

  /// Create a copy of MessageReadInfoModel
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
    return _then(_MessageReadInfoModel(
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
