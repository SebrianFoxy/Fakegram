// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_group_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatGroupRequestDTO {
  @JsonKey(name: 'title')
  String get title;
  @JsonKey(name: 'member_ids')
  List<String> get membersIDs;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @JsonKey(name: 'description')
  String? get description;

  /// Create a copy of ChatGroupRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatGroupRequestDTOCopyWith<ChatGroupRequestDTO> get copyWith =>
      _$ChatGroupRequestDTOCopyWithImpl<ChatGroupRequestDTO>(
          this as ChatGroupRequestDTO, _$identity);

  /// Serializes this ChatGroupRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatGroupRequestDTO &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other.membersIDs, membersIDs) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title,
      const DeepCollectionEquality().hash(membersIDs), avatarUrl, description);

  @override
  String toString() {
    return 'ChatGroupRequestDTO(title: $title, membersIDs: $membersIDs, avatarUrl: $avatarUrl, description: $description)';
  }
}

/// @nodoc
abstract mixin class $ChatGroupRequestDTOCopyWith<$Res> {
  factory $ChatGroupRequestDTOCopyWith(
          ChatGroupRequestDTO value, $Res Function(ChatGroupRequestDTO) _then) =
      _$ChatGroupRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'title') String title,
      @JsonKey(name: 'member_ids') List<String> membersIDs,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'description') String? description});
}

/// @nodoc
class _$ChatGroupRequestDTOCopyWithImpl<$Res>
    implements $ChatGroupRequestDTOCopyWith<$Res> {
  _$ChatGroupRequestDTOCopyWithImpl(this._self, this._then);

  final ChatGroupRequestDTO _self;
  final $Res Function(ChatGroupRequestDTO) _then;

  /// Create a copy of ChatGroupRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? membersIDs = null,
    Object? avatarUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      membersIDs: null == membersIDs
          ? _self.membersIDs
          : membersIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [ChatGroupRequestDTO].
extension ChatGroupRequestDTOPatterns on ChatGroupRequestDTO {
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
    TResult Function(_ChatGroupRequestDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO() when $default != null:
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
    TResult Function(_ChatGroupRequestDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO():
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
    TResult? Function(_ChatGroupRequestDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO() when $default != null:
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
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'member_ids') List<String> membersIDs,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'description') String? description)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO() when $default != null:
        return $default(
            _that.title, _that.membersIDs, _that.avatarUrl, _that.description);
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
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'member_ids') List<String> membersIDs,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'description') String? description)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO():
        return $default(
            _that.title, _that.membersIDs, _that.avatarUrl, _that.description);
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
            @JsonKey(name: 'title') String title,
            @JsonKey(name: 'member_ids') List<String> membersIDs,
            @JsonKey(name: 'avatar_url') String? avatarUrl,
            @JsonKey(name: 'description') String? description)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _ChatGroupRequestDTO() when $default != null:
        return $default(
            _that.title, _that.membersIDs, _that.avatarUrl, _that.description);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _ChatGroupRequestDTO implements ChatGroupRequestDTO {
  const _ChatGroupRequestDTO(
      {@JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'member_ids') required final List<String> membersIDs,
      @JsonKey(name: 'avatar_url') this.avatarUrl,
      @JsonKey(name: 'description') this.description})
      : _membersIDs = membersIDs;
  factory _ChatGroupRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatGroupRequestDTOFromJson(json);

  @override
  @JsonKey(name: 'title')
  final String title;
  final List<String> _membersIDs;
  @override
  @JsonKey(name: 'member_ids')
  List<String> get membersIDs {
    if (_membersIDs is EqualUnmodifiableListView) return _membersIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_membersIDs);
  }

  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'description')
  final String? description;

  /// Create a copy of ChatGroupRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatGroupRequestDTOCopyWith<_ChatGroupRequestDTO> get copyWith =>
      __$ChatGroupRequestDTOCopyWithImpl<_ChatGroupRequestDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatGroupRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatGroupRequestDTO &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._membersIDs, _membersIDs) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title,
      const DeepCollectionEquality().hash(_membersIDs), avatarUrl, description);

  @override
  String toString() {
    return 'ChatGroupRequestDTO(title: $title, membersIDs: $membersIDs, avatarUrl: $avatarUrl, description: $description)';
  }
}

/// @nodoc
abstract mixin class _$ChatGroupRequestDTOCopyWith<$Res>
    implements $ChatGroupRequestDTOCopyWith<$Res> {
  factory _$ChatGroupRequestDTOCopyWith(_ChatGroupRequestDTO value,
          $Res Function(_ChatGroupRequestDTO) _then) =
      __$ChatGroupRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'title') String title,
      @JsonKey(name: 'member_ids') List<String> membersIDs,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'description') String? description});
}

/// @nodoc
class __$ChatGroupRequestDTOCopyWithImpl<$Res>
    implements _$ChatGroupRequestDTOCopyWith<$Res> {
  __$ChatGroupRequestDTOCopyWithImpl(this._self, this._then);

  final _ChatGroupRequestDTO _self;
  final $Res Function(_ChatGroupRequestDTO) _then;

  /// Create a copy of ChatGroupRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? membersIDs = null,
    Object? avatarUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_ChatGroupRequestDTO(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      membersIDs: null == membersIDs
          ? _self._membersIDs
          : membersIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
