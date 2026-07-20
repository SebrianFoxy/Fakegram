// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_chat_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchChatResponseDTO {
  @JsonKey(name: "chats")
  List<DirectChatModel> get chats;
  @JsonKey(name: "count")
  int get count;
  @JsonKey(name: "query")
  String get query;

  /// Create a copy of SearchChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchChatResponseDTOCopyWith<SearchChatResponseDTO> get copyWith =>
      _$SearchChatResponseDTOCopyWithImpl<SearchChatResponseDTO>(
          this as SearchChatResponseDTO, _$identity);

  /// Serializes this SearchChatResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchChatResponseDTO &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.query, query) || other.query == query));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(chats), count, query);

  @override
  String toString() {
    return 'SearchChatResponseDTO(chats: $chats, count: $count, query: $query)';
  }
}

/// @nodoc
abstract mixin class $SearchChatResponseDTOCopyWith<$Res> {
  factory $SearchChatResponseDTOCopyWith(SearchChatResponseDTO value,
          $Res Function(SearchChatResponseDTO) _then) =
      _$SearchChatResponseDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "chats") List<DirectChatModel> chats,
      @JsonKey(name: "count") int count,
      @JsonKey(name: "query") String query});
}

/// @nodoc
class _$SearchChatResponseDTOCopyWithImpl<$Res>
    implements $SearchChatResponseDTOCopyWith<$Res> {
  _$SearchChatResponseDTOCopyWithImpl(this._self, this._then);

  final SearchChatResponseDTO _self;
  final $Res Function(SearchChatResponseDTO) _then;

  /// Create a copy of SearchChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? count = null,
    Object? query = null,
  }) {
    return _then(_self.copyWith(
      chats: null == chats
          ? _self.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<DirectChatModel>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// Adds pattern-matching-related methods to [SearchChatResponseDTO].
extension SearchChatResponseDTOPatterns on SearchChatResponseDTO {
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
    TResult Function(_SearchChatResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO() when $default != null:
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
    TResult Function(_SearchChatResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO():
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
    TResult? Function(_SearchChatResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO() when $default != null:
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
            @JsonKey(name: "chats") List<DirectChatModel> chats,
            @JsonKey(name: "count") int count,
            @JsonKey(name: "query") String query)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO() when $default != null:
        return $default(_that.chats, _that.count, _that.query);
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
            @JsonKey(name: "chats") List<DirectChatModel> chats,
            @JsonKey(name: "count") int count,
            @JsonKey(name: "query") String query)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO():
        return $default(_that.chats, _that.count, _that.query);
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
            @JsonKey(name: "chats") List<DirectChatModel> chats,
            @JsonKey(name: "count") int count,
            @JsonKey(name: "query") String query)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchChatResponseDTO() when $default != null:
        return $default(_that.chats, _that.count, _that.query);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SearchChatResponseDTO implements SearchChatResponseDTO {
  const _SearchChatResponseDTO(
      {@JsonKey(name: "chats") required final List<DirectChatModel> chats,
      @JsonKey(name: "count") required this.count,
      @JsonKey(name: "query") required this.query})
      : _chats = chats;
  factory _SearchChatResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$SearchChatResponseDTOFromJson(json);

  final List<DirectChatModel> _chats;
  @override
  @JsonKey(name: "chats")
  List<DirectChatModel> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  @JsonKey(name: "count")
  final int count;
  @override
  @JsonKey(name: "query")
  final String query;

  /// Create a copy of SearchChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchChatResponseDTOCopyWith<_SearchChatResponseDTO> get copyWith =>
      __$SearchChatResponseDTOCopyWithImpl<_SearchChatResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SearchChatResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchChatResponseDTO &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.query, query) || other.query == query));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_chats), count, query);

  @override
  String toString() {
    return 'SearchChatResponseDTO(chats: $chats, count: $count, query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SearchChatResponseDTOCopyWith<$Res>
    implements $SearchChatResponseDTOCopyWith<$Res> {
  factory _$SearchChatResponseDTOCopyWith(_SearchChatResponseDTO value,
          $Res Function(_SearchChatResponseDTO) _then) =
      __$SearchChatResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chats") List<DirectChatModel> chats,
      @JsonKey(name: "count") int count,
      @JsonKey(name: "query") String query});
}

/// @nodoc
class __$SearchChatResponseDTOCopyWithImpl<$Res>
    implements _$SearchChatResponseDTOCopyWith<$Res> {
  __$SearchChatResponseDTOCopyWithImpl(this._self, this._then);

  final _SearchChatResponseDTO _self;
  final $Res Function(_SearchChatResponseDTO) _then;

  /// Create a copy of SearchChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chats = null,
    Object? count = null,
    Object? query = null,
  }) {
    return _then(_SearchChatResponseDTO(
      chats: null == chats
          ? _self._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<DirectChatModel>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
