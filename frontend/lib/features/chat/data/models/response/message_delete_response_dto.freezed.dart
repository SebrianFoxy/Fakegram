// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_delete_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageDeleteResponseDTO {
  @JsonKey(name: "error")
  String? get error;

  /// Create a copy of MessageDeleteResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageDeleteResponseDTOCopyWith<MessageDeleteResponseDTO> get copyWith =>
      _$MessageDeleteResponseDTOCopyWithImpl<MessageDeleteResponseDTO>(
          this as MessageDeleteResponseDTO, _$identity);

  /// Serializes this MessageDeleteResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageDeleteResponseDTO &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'MessageDeleteResponseDTO(error: $error)';
  }
}

/// @nodoc
abstract mixin class $MessageDeleteResponseDTOCopyWith<$Res> {
  factory $MessageDeleteResponseDTOCopyWith(MessageDeleteResponseDTO value,
          $Res Function(MessageDeleteResponseDTO) _then) =
      _$MessageDeleteResponseDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: "error") String? error});
}

/// @nodoc
class _$MessageDeleteResponseDTOCopyWithImpl<$Res>
    implements $MessageDeleteResponseDTOCopyWith<$Res> {
  _$MessageDeleteResponseDTOCopyWithImpl(this._self, this._then);

  final MessageDeleteResponseDTO _self;
  final $Res Function(MessageDeleteResponseDTO) _then;

  /// Create a copy of MessageDeleteResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageDeleteResponseDTO].
extension MessageDeleteResponseDTOPatterns on MessageDeleteResponseDTO {
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
    TResult Function(_MessageDeleteResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO() when $default != null:
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
    TResult Function(_MessageDeleteResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO():
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
    TResult? Function(_MessageDeleteResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO() when $default != null:
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
    TResult Function(@JsonKey(name: "error") String? error)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO() when $default != null:
        return $default(_that.error);
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
    TResult Function(@JsonKey(name: "error") String? error) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO():
        return $default(_that.error);
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
    TResult? Function(@JsonKey(name: "error") String? error)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDeleteResponseDTO() when $default != null:
        return $default(_that.error);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageDeleteResponseDTO implements MessageDeleteResponseDTO {
  const _MessageDeleteResponseDTO({@JsonKey(name: "error") this.error});
  factory _MessageDeleteResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageDeleteResponseDTOFromJson(json);

  @override
  @JsonKey(name: "error")
  final String? error;

  /// Create a copy of MessageDeleteResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageDeleteResponseDTOCopyWith<_MessageDeleteResponseDTO> get copyWith =>
      __$MessageDeleteResponseDTOCopyWithImpl<_MessageDeleteResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageDeleteResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageDeleteResponseDTO &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'MessageDeleteResponseDTO(error: $error)';
  }
}

/// @nodoc
abstract mixin class _$MessageDeleteResponseDTOCopyWith<$Res>
    implements $MessageDeleteResponseDTOCopyWith<$Res> {
  factory _$MessageDeleteResponseDTOCopyWith(_MessageDeleteResponseDTO value,
          $Res Function(_MessageDeleteResponseDTO) _then) =
      __$MessageDeleteResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: "error") String? error});
}

/// @nodoc
class __$MessageDeleteResponseDTOCopyWithImpl<$Res>
    implements _$MessageDeleteResponseDTOCopyWith<$Res> {
  __$MessageDeleteResponseDTOCopyWithImpl(this._self, this._then);

  final _MessageDeleteResponseDTO _self;
  final $Res Function(_MessageDeleteResponseDTO) _then;

  /// Create a copy of MessageDeleteResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_MessageDeleteResponseDTO(
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
