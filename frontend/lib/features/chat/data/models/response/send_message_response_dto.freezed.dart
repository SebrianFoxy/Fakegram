// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_message_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SendMessageResponseDTO {
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'message')
  MessageDetailModel get message;

  /// Create a copy of SendMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SendMessageResponseDTOCopyWith<SendMessageResponseDTO> get copyWith =>
      _$SendMessageResponseDTOCopyWithImpl<SendMessageResponseDTO>(
          this as SendMessageResponseDTO, _$identity);

  /// Serializes this SendMessageResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SendMessageResponseDTO &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, message);

  @override
  String toString() {
    return 'SendMessageResponseDTO(chatId: $chatId, message: $message)';
  }
}

/// @nodoc
abstract mixin class $SendMessageResponseDTOCopyWith<$Res> {
  factory $SendMessageResponseDTOCopyWith(SendMessageResponseDTO value,
          $Res Function(SendMessageResponseDTO) _then) =
      _$SendMessageResponseDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'message') MessageDetailModel message});

  $MessageDetailModelCopyWith<$Res> get message;
}

/// @nodoc
class _$SendMessageResponseDTOCopyWithImpl<$Res>
    implements $SendMessageResponseDTOCopyWith<$Res> {
  _$SendMessageResponseDTOCopyWithImpl(this._self, this._then);

  final SendMessageResponseDTO _self;
  final $Res Function(SendMessageResponseDTO) _then;

  /// Create a copy of SendMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? message = null,
  }) {
    return _then(_self.copyWith(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel,
    ));
  }

  /// Create a copy of SendMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<$Res> get message {
    return $MessageDetailModelCopyWith<$Res>(_self.message, (value) {
      return _then(_self.copyWith(message: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SendMessageResponseDTO].
extension SendMessageResponseDTOPatterns on SendMessageResponseDTO {
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
    TResult Function(_SendMessageResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO() when $default != null:
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
    TResult Function(_SendMessageResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO():
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
    TResult? Function(_SendMessageResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO() when $default != null:
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
    TResult Function(@JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'message') MessageDetailModel message)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO() when $default != null:
        return $default(_that.chatId, _that.message);
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
    TResult Function(@JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'message') MessageDetailModel message)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO():
        return $default(_that.chatId, _that.message);
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
    TResult? Function(@JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'message') MessageDetailModel message)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SendMessageResponseDTO() when $default != null:
        return $default(_that.chatId, _that.message);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SendMessageResponseDTO implements SendMessageResponseDTO {
  const _SendMessageResponseDTO(
      {@JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'message') required this.message});
  factory _SendMessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SendMessageResponseDTOFromJson(json);

  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'message')
  final MessageDetailModel message;

  /// Create a copy of SendMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SendMessageResponseDTOCopyWith<_SendMessageResponseDTO> get copyWith =>
      __$SendMessageResponseDTOCopyWithImpl<_SendMessageResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SendMessageResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SendMessageResponseDTO &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chatId, message);

  @override
  String toString() {
    return 'SendMessageResponseDTO(chatId: $chatId, message: $message)';
  }
}

/// @nodoc
abstract mixin class _$SendMessageResponseDTOCopyWith<$Res>
    implements $SendMessageResponseDTOCopyWith<$Res> {
  factory _$SendMessageResponseDTOCopyWith(_SendMessageResponseDTO value,
          $Res Function(_SendMessageResponseDTO) _then) =
      __$SendMessageResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'message') MessageDetailModel message});

  @override
  $MessageDetailModelCopyWith<$Res> get message;
}

/// @nodoc
class __$SendMessageResponseDTOCopyWithImpl<$Res>
    implements _$SendMessageResponseDTOCopyWith<$Res> {
  __$SendMessageResponseDTOCopyWithImpl(this._self, this._then);

  final _SendMessageResponseDTO _self;
  final $Res Function(_SendMessageResponseDTO) _then;

  /// Create a copy of SendMessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chatId = null,
    Object? message = null,
  }) {
    return _then(_SendMessageResponseDTO(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel,
    ));
  }

  /// Create a copy of SendMessageResponseDTO
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
