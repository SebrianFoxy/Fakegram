// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'token_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TokenRequestDTO {
  @JsonKey(name: "refresh_rotate")
  bool get refreshRotate;
  @JsonKey(name: "refresh_token")
  String get refreshToken;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenRequestDTOCopyWith<TokenRequestDTO> get copyWith =>
      _$TokenRequestDTOCopyWithImpl<TokenRequestDTO>(
          this as TokenRequestDTO, _$identity);

  /// Serializes this TokenRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenRequestDTO &&
            (identical(other.refreshRotate, refreshRotate) ||
                other.refreshRotate == refreshRotate) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshRotate, refreshToken);

  @override
  String toString() {
    return 'TokenRequestDTO(refreshRotate: $refreshRotate, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $TokenRequestDTOCopyWith<$Res> {
  factory $TokenRequestDTOCopyWith(
          TokenRequestDTO value, $Res Function(TokenRequestDTO) _then) =
      _$TokenRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "refresh_rotate") bool refreshRotate,
      @JsonKey(name: "refresh_token") String refreshToken});
}

/// @nodoc
class _$TokenRequestDTOCopyWithImpl<$Res>
    implements $TokenRequestDTOCopyWith<$Res> {
  _$TokenRequestDTOCopyWithImpl(this._self, this._then);

  final TokenRequestDTO _self;
  final $Res Function(TokenRequestDTO) _then;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? refreshRotate = null,
    Object? refreshToken = null,
  }) {
    return _then(_self.copyWith(
      refreshRotate: null == refreshRotate
          ? _self.refreshRotate
          : refreshRotate // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [TokenRequestDTO].
extension TokenRequestDTOPatterns on TokenRequestDTO {
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
    TResult Function(_TokenRequestDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO() when $default != null:
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
    TResult Function(_TokenRequestDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO():
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
    TResult? Function(_TokenRequestDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO() when $default != null:
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
    TResult Function(@JsonKey(name: "refresh_rotate") bool refreshRotate,
            @JsonKey(name: "refresh_token") String refreshToken)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO() when $default != null:
        return $default(_that.refreshRotate, _that.refreshToken);
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
    TResult Function(@JsonKey(name: "refresh_rotate") bool refreshRotate,
            @JsonKey(name: "refresh_token") String refreshToken)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO():
        return $default(_that.refreshRotate, _that.refreshToken);
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
    TResult? Function(@JsonKey(name: "refresh_rotate") bool refreshRotate,
            @JsonKey(name: "refresh_token") String refreshToken)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TokenRequestDTO() when $default != null:
        return $default(_that.refreshRotate, _that.refreshToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _TokenRequestDTO implements TokenRequestDTO {
  const _TokenRequestDTO(
      {@JsonKey(name: "refresh_rotate") required this.refreshRotate,
      @JsonKey(name: "refresh_token") required this.refreshToken});
  factory _TokenRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$TokenRequestDTOFromJson(json);

  @override
  @JsonKey(name: "refresh_rotate")
  final bool refreshRotate;
  @override
  @JsonKey(name: "refresh_token")
  final String refreshToken;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenRequestDTOCopyWith<_TokenRequestDTO> get copyWith =>
      __$TokenRequestDTOCopyWithImpl<_TokenRequestDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenRequestDTO &&
            (identical(other.refreshRotate, refreshRotate) ||
                other.refreshRotate == refreshRotate) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, refreshRotate, refreshToken);

  @override
  String toString() {
    return 'TokenRequestDTO(refreshRotate: $refreshRotate, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$TokenRequestDTOCopyWith<$Res>
    implements $TokenRequestDTOCopyWith<$Res> {
  factory _$TokenRequestDTOCopyWith(
          _TokenRequestDTO value, $Res Function(_TokenRequestDTO) _then) =
      __$TokenRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "refresh_rotate") bool refreshRotate,
      @JsonKey(name: "refresh_token") String refreshToken});
}

/// @nodoc
class __$TokenRequestDTOCopyWithImpl<$Res>
    implements _$TokenRequestDTOCopyWith<$Res> {
  __$TokenRequestDTOCopyWithImpl(this._self, this._then);

  final _TokenRequestDTO _self;
  final $Res Function(_TokenRequestDTO) _then;

  /// Create a copy of TokenRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? refreshRotate = null,
    Object? refreshToken = null,
  }) {
    return _then(_TokenRequestDTO(
      refreshRotate: null == refreshRotate
          ? _self.refreshRotate
          : refreshRotate // ignore: cast_nullable_to_non_nullable
              as bool,
      refreshToken: null == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
