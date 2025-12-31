// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatResponseDTO {
  @JsonKey(name: "chats")
  List<DirectChatModel> get chats;
  @JsonKey(name: "count")
  int get count;

  /// Create a copy of ChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatResponseDTOCopyWith<ChatResponseDTO> get copyWith =>
      _$ChatResponseDTOCopyWithImpl<ChatResponseDTO>(
          this as ChatResponseDTO, _$identity);

  /// Serializes this ChatResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatResponseDTO &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(chats), count);

  @override
  String toString() {
    return 'ChatResponseDTO(chats: $chats, count: $count)';
  }
}

/// @nodoc
abstract mixin class $ChatResponseDTOCopyWith<$Res> {
  factory $ChatResponseDTOCopyWith(
          ChatResponseDTO value, $Res Function(ChatResponseDTO) _then) =
      _$ChatResponseDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "chats") List<DirectChatModel> chats,
      @JsonKey(name: "count") int count});
}

/// @nodoc
class _$ChatResponseDTOCopyWithImpl<$Res>
    implements $ChatResponseDTOCopyWith<$Res> {
  _$ChatResponseDTOCopyWithImpl(this._self, this._then);

  final ChatResponseDTO _self;
  final $Res Function(ChatResponseDTO) _then;

  /// Create a copy of ChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
    Object? count = null,
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
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatResponseDTO implements ChatResponseDTO {
  const _ChatResponseDTO(
      {@JsonKey(name: "chats") required final List<DirectChatModel> chats,
      @JsonKey(name: "count") required this.count})
      : _chats = chats;
  factory _ChatResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$ChatResponseDTOFromJson(json);

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

  /// Create a copy of ChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatResponseDTOCopyWith<_ChatResponseDTO> get copyWith =>
      __$ChatResponseDTOCopyWithImpl<_ChatResponseDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatResponseDTO &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_chats), count);

  @override
  String toString() {
    return 'ChatResponseDTO(chats: $chats, count: $count)';
  }
}

/// @nodoc
abstract mixin class _$ChatResponseDTOCopyWith<$Res>
    implements $ChatResponseDTOCopyWith<$Res> {
  factory _$ChatResponseDTOCopyWith(
          _ChatResponseDTO value, $Res Function(_ChatResponseDTO) _then) =
      __$ChatResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "chats") List<DirectChatModel> chats,
      @JsonKey(name: "count") int count});
}

/// @nodoc
class __$ChatResponseDTOCopyWithImpl<$Res>
    implements _$ChatResponseDTOCopyWith<$Res> {
  __$ChatResponseDTOCopyWithImpl(this._self, this._then);

  final _ChatResponseDTO _self;
  final $Res Function(_ChatResponseDTO) _then;

  /// Create a copy of ChatResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chats = null,
    Object? count = null,
  }) {
    return _then(_ChatResponseDTO(
      chats: null == chats
          ? _self._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<DirectChatModel>,
      count: null == count
          ? _self.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
