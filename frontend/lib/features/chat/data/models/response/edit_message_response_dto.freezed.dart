// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'edit_message_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EditMessageResponseDTO {
  @JsonKey(name: 'message')
  MessageDetailModel get message;

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EditMessageResponseDTOCopyWith<EditMessageResponseDTO> get copyWith =>
      _$EditMessageResponseDTOCopyWithImpl<EditMessageResponseDTO>(
          this as EditMessageResponseDTO, _$identity);

  /// Serializes this EditMessageResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EditMessageResponseDTO &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'EditMessageResponseDTO(message: $message)';
  }
}

/// @nodoc
abstract mixin class $EditMessageResponseDTOCopyWith<$Res> {
  factory $EditMessageResponseDTOCopyWith(EditMessageResponseDTO value,
          $Res Function(EditMessageResponseDTO) _then) =
      _$EditMessageResponseDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'message') MessageDetailModel message});

  $MessageDetailModelCopyWith<$Res> get message;
}

/// @nodoc
class _$EditMessageResponseDTOCopyWithImpl<$Res>
    implements $EditMessageResponseDTOCopyWith<$Res> {
  _$EditMessageResponseDTOCopyWithImpl(this._self, this._then);

  final EditMessageResponseDTO _self;
  final $Res Function(EditMessageResponseDTO) _then;

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel,
    ));
  }

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<$Res> get message {
    return $MessageDetailModelCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// Adds pattern-matching-related methods to [EditMessageResponseDTO].
extension EditMessageResponseDTOPatterns on EditMessageResponseDTO {
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
    TResult Function(_EditMessageResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO() when $default != null:
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
    TResult Function(_EditMessageResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO():
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
    TResult? Function(_EditMessageResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO() when $default != null:
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
    TResult Function(@JsonKey(name: 'message') MessageDetailModel message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO() when $default != null:
        return $default(_that.message);
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
    TResult Function(@JsonKey(name: 'message') MessageDetailModel message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO():
        return $default(_that.message);
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
    TResult? Function(@JsonKey(name: 'message') MessageDetailModel message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _EditMessageResponseDTO() when $default != null:
        return $default(_that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _EditMessageResponseDTO implements EditMessageResponseDTO {
  const _EditMessageResponseDTO(
      {@JsonKey(name: 'message') required this.message});
  factory _EditMessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$EditMessageResponseDTOFromJson(json);

  @override
  @JsonKey(name: 'message')
  final MessageDetailModel message;

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EditMessageResponseDTOCopyWith<_EditMessageResponseDTO> get copyWith =>
      __$EditMessageResponseDTOCopyWithImpl<_EditMessageResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EditMessageResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EditMessageResponseDTO &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message);

  @override
  String toString() {
    return 'EditMessageResponseDTO(message: $message)';
  }
}

/// @nodoc
abstract mixin class _$EditMessageResponseDTOCopyWith<$Res>
    implements $EditMessageResponseDTOCopyWith<$Res> {
  factory _$EditMessageResponseDTOCopyWith(_EditMessageResponseDTO value,
          $Res Function(_EditMessageResponseDTO) _then) =
      __$EditMessageResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'message') MessageDetailModel message});

  @override
  $MessageDetailModelCopyWith<$Res> get message;
}

/// @nodoc
class __$EditMessageResponseDTOCopyWithImpl<$Res>
    implements _$EditMessageResponseDTOCopyWith<$Res> {
  __$EditMessageResponseDTOCopyWithImpl(this._self, this._then);

  final _EditMessageResponseDTO _self;
  final $Res Function(_EditMessageResponseDTO) _then;

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? message = null,
  }) {
    return _then(_EditMessageResponseDTO(
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel,
    ));
  }

  /// Create a copy of EditMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<$Res> get message {
    return $MessageDetailModelCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

// dart format on
