// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageResponseDTO {
  @JsonKey(name: 'messages')
  List<MessageDetailModel> get messages;
  @JsonKey(name: 'count')
  int get count;
  @JsonKey(name: 'total_unread')
  int get totalUnread;
  @JsonKey(name: 'has_more_older')
  bool get hasMoreOlder;
  @JsonKey(name: 'has_more_newer')
  bool get hasMoreNewer;
  @JsonKey(name: 'first_msg_time')
  String? get firstMsgTime;
  @JsonKey(name: 'last_msg_time')
  String? get lastMsgTime;
  @JsonKey(name: 'cursors')
  MessageCursorsModel? get cursors;

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageResponseDTOCopyWith<MessageResponseDTO> get copyWith =>
      _$MessageResponseDTOCopyWithImpl<MessageResponseDTO>(
          this as MessageResponseDTO, _$identity);

  /// Serializes this MessageResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageResponseDTO &&
            const DeepCollectionEquality().equals(other.messages, messages) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.hasMoreOlder, hasMoreOlder) ||
                other.hasMoreOlder == hasMoreOlder) &&
            (identical(other.hasMoreNewer, hasMoreNewer) ||
                other.hasMoreNewer == hasMoreNewer) &&
            (identical(other.firstMsgTime, firstMsgTime) ||
                other.firstMsgTime == firstMsgTime) &&
            (identical(other.lastMsgTime, lastMsgTime) ||
                other.lastMsgTime == lastMsgTime) &&
            (identical(other.cursors, cursors) || other.cursors == cursors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      count,
      totalUnread,
      hasMoreOlder,
      hasMoreNewer,
      firstMsgTime,
      lastMsgTime,
      cursors);

  @override
  String toString() {
    return 'MessageResponseDTO(messages: $messages, count: $count, totalUnread: $totalUnread, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, firstMsgTime: $firstMsgTime, lastMsgTime: $lastMsgTime, cursors: $cursors)';
  }
}

/// @nodoc
abstract mixin class $MessageResponseDTOCopyWith<$Res> {
  factory $MessageResponseDTOCopyWith(
          MessageResponseDTO value, $Res Function(MessageResponseDTO) _then) =
      _$MessageResponseDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'messages') List<MessageDetailModel> messages,
      @JsonKey(name: 'count') int count,
      @JsonKey(name: 'total_unread') int totalUnread,
      @JsonKey(name: 'has_more_older') bool hasMoreOlder,
      @JsonKey(name: 'has_more_newer') bool hasMoreNewer,
      @JsonKey(name: 'first_msg_time') String? firstMsgTime,
      @JsonKey(name: 'last_msg_time') String? lastMsgTime,
      @JsonKey(name: 'cursors') MessageCursorsModel? cursors});

  $MessageCursorsModelCopyWith<$Res>? get cursors;
}

/// @nodoc
class _$MessageResponseDTOCopyWithImpl<$Res>
    implements $MessageResponseDTOCopyWith<$Res> {
  _$MessageResponseDTOCopyWithImpl(this._self, this._then);

  final MessageResponseDTO _self;
  final $Res Function(MessageResponseDTO) _then;

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? count = null,
    Object? totalUnread = null,
    Object? hasMoreOlder = null,
    Object? hasMoreNewer = null,
    Object? firstMsgTime = freezed,
    Object? lastMsgTime = freezed,
    Object? cursors = freezed,
  }) {
    return _then(_self.copyWith(
      messages: null == messages
          ? _self.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageDetailModel>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalUnread: null == totalUnread
          ? _self.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreOlder: null == hasMoreOlder
          ? _self.hasMoreOlder
          : hasMoreOlder // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreNewer: null == hasMoreNewer
          ? _self.hasMoreNewer
          : hasMoreNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      firstMsgTime: freezed == firstMsgTime
          ? _self.firstMsgTime
          : firstMsgTime // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMsgTime: freezed == lastMsgTime
          ? _self.lastMsgTime
          : lastMsgTime // ignore: cast_nullable_to_non_nullable
              as String?,
      cursors: freezed == cursors
          ? _self.cursors
          : cursors // ignore: cast_nullable_to_non_nullable
              as MessageCursorsModel?,
    ));
  }

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCursorsModelCopyWith<$Res>? get cursors {
    if (_self.cursors == null) {
      return null;
    }

    return $MessageCursorsModelCopyWith<$Res>(_self.cursors!, (value) {
      return _then(_self.copyWith(cursors: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MessageResponseDTO].
extension MessageResponseDTOPatterns on MessageResponseDTO {
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
    TResult Function(_MessageResponseDTO value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO() when $default != null:
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
    TResult Function(_MessageResponseDTO value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO():
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
    TResult? Function(_MessageResponseDTO value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO() when $default != null:
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
            @JsonKey(name: 'messages') List<MessageDetailModel> messages,
            @JsonKey(name: 'count') int count,
            @JsonKey(name: 'total_unread') int totalUnread,
            @JsonKey(name: 'has_more_older') bool hasMoreOlder,
            @JsonKey(name: 'has_more_newer') bool hasMoreNewer,
            @JsonKey(name: 'first_msg_time') String? firstMsgTime,
            @JsonKey(name: 'last_msg_time') String? lastMsgTime,
            @JsonKey(name: 'cursors') MessageCursorsModel? cursors)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO() when $default != null:
        return $default(
            _that.messages,
            _that.count,
            _that.totalUnread,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.firstMsgTime,
            _that.lastMsgTime,
            _that.cursors);
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
            @JsonKey(name: 'messages') List<MessageDetailModel> messages,
            @JsonKey(name: 'count') int count,
            @JsonKey(name: 'total_unread') int totalUnread,
            @JsonKey(name: 'has_more_older') bool hasMoreOlder,
            @JsonKey(name: 'has_more_newer') bool hasMoreNewer,
            @JsonKey(name: 'first_msg_time') String? firstMsgTime,
            @JsonKey(name: 'last_msg_time') String? lastMsgTime,
            @JsonKey(name: 'cursors') MessageCursorsModel? cursors)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO():
        return $default(
            _that.messages,
            _that.count,
            _that.totalUnread,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.firstMsgTime,
            _that.lastMsgTime,
            _that.cursors);
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
            @JsonKey(name: 'messages') List<MessageDetailModel> messages,
            @JsonKey(name: 'count') int count,
            @JsonKey(name: 'total_unread') int totalUnread,
            @JsonKey(name: 'has_more_older') bool hasMoreOlder,
            @JsonKey(name: 'has_more_newer') bool hasMoreNewer,
            @JsonKey(name: 'first_msg_time') String? firstMsgTime,
            @JsonKey(name: 'last_msg_time') String? lastMsgTime,
            @JsonKey(name: 'cursors') MessageCursorsModel? cursors)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageResponseDTO() when $default != null:
        return $default(
            _that.messages,
            _that.count,
            _that.totalUnread,
            _that.hasMoreOlder,
            _that.hasMoreNewer,
            _that.firstMsgTime,
            _that.lastMsgTime,
            _that.cursors);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageResponseDTO implements MessageResponseDTO {
  const _MessageResponseDTO(
      {@JsonKey(name: 'messages')
      required final List<MessageDetailModel> messages,
      @JsonKey(name: 'count') required this.count,
      @JsonKey(name: 'total_unread') required this.totalUnread,
      @JsonKey(name: 'has_more_older') required this.hasMoreOlder,
      @JsonKey(name: 'has_more_newer') required this.hasMoreNewer,
      @JsonKey(name: 'first_msg_time') this.firstMsgTime,
      @JsonKey(name: 'last_msg_time') this.lastMsgTime,
      @JsonKey(name: 'cursors') this.cursors})
      : _messages = messages;
  factory _MessageResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseDTOFromJson(json);

  final List<MessageDetailModel> _messages;
  @override
  @JsonKey(name: 'messages')
  List<MessageDetailModel> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey(name: 'count')
  final int count;
  @override
  @JsonKey(name: 'total_unread')
  final int totalUnread;
  @override
  @JsonKey(name: 'has_more_older')
  final bool hasMoreOlder;
  @override
  @JsonKey(name: 'has_more_newer')
  final bool hasMoreNewer;
  @override
  @JsonKey(name: 'first_msg_time')
  final String? firstMsgTime;
  @override
  @JsonKey(name: 'last_msg_time')
  final String? lastMsgTime;
  @override
  @JsonKey(name: 'cursors')
  final MessageCursorsModel? cursors;

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageResponseDTOCopyWith<_MessageResponseDTO> get copyWith =>
      __$MessageResponseDTOCopyWithImpl<_MessageResponseDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageResponseDTO &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.totalUnread, totalUnread) ||
                other.totalUnread == totalUnread) &&
            (identical(other.hasMoreOlder, hasMoreOlder) ||
                other.hasMoreOlder == hasMoreOlder) &&
            (identical(other.hasMoreNewer, hasMoreNewer) ||
                other.hasMoreNewer == hasMoreNewer) &&
            (identical(other.firstMsgTime, firstMsgTime) ||
                other.firstMsgTime == firstMsgTime) &&
            (identical(other.lastMsgTime, lastMsgTime) ||
                other.lastMsgTime == lastMsgTime) &&
            (identical(other.cursors, cursors) || other.cursors == cursors));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      count,
      totalUnread,
      hasMoreOlder,
      hasMoreNewer,
      firstMsgTime,
      lastMsgTime,
      cursors);

  @override
  String toString() {
    return 'MessageResponseDTO(messages: $messages, count: $count, totalUnread: $totalUnread, hasMoreOlder: $hasMoreOlder, hasMoreNewer: $hasMoreNewer, firstMsgTime: $firstMsgTime, lastMsgTime: $lastMsgTime, cursors: $cursors)';
  }
}

/// @nodoc
abstract mixin class _$MessageResponseDTOCopyWith<$Res>
    implements $MessageResponseDTOCopyWith<$Res> {
  factory _$MessageResponseDTOCopyWith(
          _MessageResponseDTO value, $Res Function(_MessageResponseDTO) _then) =
      __$MessageResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'messages') List<MessageDetailModel> messages,
      @JsonKey(name: 'count') int count,
      @JsonKey(name: 'total_unread') int totalUnread,
      @JsonKey(name: 'has_more_older') bool hasMoreOlder,
      @JsonKey(name: 'has_more_newer') bool hasMoreNewer,
      @JsonKey(name: 'first_msg_time') String? firstMsgTime,
      @JsonKey(name: 'last_msg_time') String? lastMsgTime,
      @JsonKey(name: 'cursors') MessageCursorsModel? cursors});

  @override
  $MessageCursorsModelCopyWith<$Res>? get cursors;
}

/// @nodoc
class __$MessageResponseDTOCopyWithImpl<$Res>
    implements _$MessageResponseDTOCopyWith<$Res> {
  __$MessageResponseDTOCopyWithImpl(this._self, this._then);

  final _MessageResponseDTO _self;
  final $Res Function(_MessageResponseDTO) _then;

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? messages = null,
    Object? count = null,
    Object? totalUnread = null,
    Object? hasMoreOlder = null,
    Object? hasMoreNewer = null,
    Object? firstMsgTime = freezed,
    Object? lastMsgTime = freezed,
    Object? cursors = freezed,
  }) {
    return _then(_MessageResponseDTO(
      messages: null == messages
          ? _self._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MessageDetailModel>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      totalUnread: null == totalUnread
          ? _self.totalUnread
          : totalUnread // ignore: cast_nullable_to_non_nullable
              as int,
      hasMoreOlder: null == hasMoreOlder
          ? _self.hasMoreOlder
          : hasMoreOlder // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreNewer: null == hasMoreNewer
          ? _self.hasMoreNewer
          : hasMoreNewer // ignore: cast_nullable_to_non_nullable
              as bool,
      firstMsgTime: freezed == firstMsgTime
          ? _self.firstMsgTime
          : firstMsgTime // ignore: cast_nullable_to_non_nullable
              as String?,
      lastMsgTime: freezed == lastMsgTime
          ? _self.lastMsgTime
          : lastMsgTime // ignore: cast_nullable_to_non_nullable
              as String?,
      cursors: freezed == cursors
          ? _self.cursors
          : cursors // ignore: cast_nullable_to_non_nullable
              as MessageCursorsModel?,
    ));
  }

  /// Create a copy of MessageResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageCursorsModelCopyWith<$Res>? get cursors {
    if (_self.cursors == null) {
      return null;
    }

    return $MessageCursorsModelCopyWith<$Res>(_self.cursors!, (value) {
      return _then(_self.copyWith(cursors: value));
    });
  }
}

// dart format on
