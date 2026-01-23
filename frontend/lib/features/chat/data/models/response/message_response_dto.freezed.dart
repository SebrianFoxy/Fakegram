// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
  @JsonKey(name: 'total')
  int get total;
  @JsonKey(name: 'page')
  int get page;
  @JsonKey(name: 'limit')
  int get limit;
  @JsonKey(name: 'has_next')
  bool get hasNext;
  @JsonKey(name: 'has_prev')
  bool get hasPrev;

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
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(messages),
      count,
      total,
      page,
      limit,
      hasNext,
      hasPrev);

  @override
  String toString() {
    return 'MessageResponseDTO(messages: $messages, count: $count, total: $total, page: $page, limit: $limit, hasNext: $hasNext, hasPrev: $hasPrev)';
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
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'has_next') bool hasNext,
      @JsonKey(name: 'has_prev') bool hasPrev});
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
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? hasNext = null,
    Object? hasPrev = null,
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
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrev: null == hasPrev
          ? _self.hasPrev
          : hasPrev // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MessageResponseDTO implements MessageResponseDTO {
  const _MessageResponseDTO(
      {@JsonKey(name: 'messages')
      required final List<MessageDetailModel> messages,
      @JsonKey(name: 'count') required this.count,
      @JsonKey(name: 'total') required this.total,
      @JsonKey(name: 'page') required this.page,
      @JsonKey(name: 'limit') required this.limit,
      @JsonKey(name: 'has_next') required this.hasNext,
      @JsonKey(name: 'has_prev') required this.hasPrev})
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
  @JsonKey(name: 'total')
  final int total;
  @override
  @JsonKey(name: 'page')
  final int page;
  @override
  @JsonKey(name: 'limit')
  final int limit;
  @override
  @JsonKey(name: 'has_next')
  final bool hasNext;
  @override
  @JsonKey(name: 'has_prev')
  final bool hasPrev;

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
            (identical(other.total, total) || other.total == total) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            (identical(other.hasPrev, hasPrev) || other.hasPrev == hasPrev));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_messages),
      count,
      total,
      page,
      limit,
      hasNext,
      hasPrev);

  @override
  String toString() {
    return 'MessageResponseDTO(messages: $messages, count: $count, total: $total, page: $page, limit: $limit, hasNext: $hasNext, hasPrev: $hasPrev)';
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
      @JsonKey(name: 'total') int total,
      @JsonKey(name: 'page') int page,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'has_next') bool hasNext,
      @JsonKey(name: 'has_prev') bool hasPrev});
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
    Object? total = null,
    Object? page = null,
    Object? limit = null,
    Object? hasNext = null,
    Object? hasPrev = null,
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
      total: null == total
          ? _self.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      page: null == page
          ? _self.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _self.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      hasNext: null == hasNext
          ? _self.hasNext
          : hasNext // ignore: cast_nullable_to_non_nullable
              as bool,
      hasPrev: null == hasPrev
          ? _self.hasPrev
          : hasPrev // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
