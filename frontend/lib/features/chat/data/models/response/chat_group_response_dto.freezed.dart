// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_group_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatGroupResponseDTO {
  @JsonKey(name: 'chat')
  DirectChatModel get chat;

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatGroupResponseDTOCopyWith<ChatGroupResponseDTO> get copyWith =>
      _$ChatGroupResponseDTOCopyWithImpl<ChatGroupResponseDTO>(
          this as ChatGroupResponseDTO, _$identity);

  /// Serializes this ChatGroupResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatGroupResponseDTO &&
            (identical(other.chat, chat) || other.chat == chat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat);

  @override
  String toString() {
    return 'ChatGroupResponseDTO(chat: $chat)';
  }
}

/// @nodoc
abstract mixin class $ChatGroupResponseDTOCopyWith<$Res> {
  factory $ChatGroupResponseDTOCopyWith(ChatGroupResponseDTO value,
          $Res Function(ChatGroupResponseDTO) _then) =
      _$ChatGroupResponseDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: 'chat') DirectChatModel chat});

  $DirectChatModelCopyWith<$Res> get chat;
}

/// @nodoc
class _$ChatGroupResponseDTOCopyWithImpl<$Res>
    implements $ChatGroupResponseDTOCopyWith<$Res> {
  _$ChatGroupResponseDTOCopyWithImpl(this._self, this._then);

  final ChatGroupResponseDTO _self;
  final $Res Function(ChatGroupResponseDTO) _then;

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chat = null,
  }) {
    return _then(_self.copyWith(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as DirectChatModel,
    ));
  }

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectChatModelCopyWith<$Res> get chat {
    return $DirectChatModelCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

/// Adds pattern-matching-related methods to [ChatGroupResponseDTO].
extension ChatGroupResponseDTOPatterns on ChatGroupResponseDTO {
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
    TResult Function(_ChatGroupResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO() when $default != null:
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
    TResult Function(_ChatGroupResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO():
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
    TResult? Function(_ChatGroupResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO() when $default != null:
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
    TResult Function(@JsonKey(name: 'chat') DirectChatModel chat)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO() when $default != null:
        return $default(_that.chat);
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
    TResult Function(@JsonKey(name: 'chat') DirectChatModel chat) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO():
        return $default(_that.chat);
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
    TResult? Function(@JsonKey(name: 'chat') DirectChatModel chat)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupResponseDTO() when $default != null:
        return $default(_that.chat);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChatGroupResponseDTO implements ChatGroupResponseDTO {
  const _ChatGroupResponseDTO({@JsonKey(name: 'chat') required this.chat});
  factory _ChatGroupResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupResponseDTOFromJson(json);

  @override
  @JsonKey(name: 'chat')
  final DirectChatModel chat;

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatGroupResponseDTOCopyWith<_ChatGroupResponseDTO> get copyWith =>
      __$ChatGroupResponseDTOCopyWithImpl<_ChatGroupResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatGroupResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatGroupResponseDTO &&
            (identical(other.chat, chat) || other.chat == chat));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, chat);

  @override
  String toString() {
    return 'ChatGroupResponseDTO(chat: $chat)';
  }
}

/// @nodoc
abstract mixin class _$ChatGroupResponseDTOCopyWith<$Res>
    implements $ChatGroupResponseDTOCopyWith<$Res> {
  factory _$ChatGroupResponseDTOCopyWith(_ChatGroupResponseDTO value,
          $Res Function(_ChatGroupResponseDTO) _then) =
      __$ChatGroupResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: 'chat') DirectChatModel chat});

  @override
  $DirectChatModelCopyWith<$Res> get chat;
}

/// @nodoc
class __$ChatGroupResponseDTOCopyWithImpl<$Res>
    implements _$ChatGroupResponseDTOCopyWith<$Res> {
  __$ChatGroupResponseDTOCopyWithImpl(this._self, this._then);

  final _ChatGroupResponseDTO _self;
  final $Res Function(_ChatGroupResponseDTO) _then;

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chat = null,
  }) {
    return _then(_ChatGroupResponseDTO(
      chat: null == chat
          ? _self.chat
          : chat // ignore: cast_nullable_to_non_nullable
              as DirectChatModel,
    ));
  }

  /// Create a copy of ChatGroupResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $DirectChatModelCopyWith<$Res> get chat {
    return $DirectChatModelCopyWith<$Res>(_self.chat, (value) {
      return _then(_self.copyWith(chat: value));
    });
  }
}

// dart format on
