// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_request_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageRequestDTO {
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'message_text')
  String get message;
  @JsonKey(name: 'message_type')
  String get messageType;
  @JsonKey(name: 'receiver_id')
  String? get receiverId;
  @JsonKey(name: 'reply_to_message_id', defaultValue: '')
  String get replyToMessageId;

  /// Create a copy of MessageRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageRequestDTOCopyWith<MessageRequestDTO> get copyWith =>
      _$MessageRequestDTOCopyWithImpl<MessageRequestDTO>(
          this as MessageRequestDTO, _$identity);

  /// Serializes this MessageRequestDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageRequestDTO &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chatId, message, messageType, receiverId, replyToMessageId);

  @override
  String toString() {
    return 'MessageRequestDTO(chatId: $chatId, message: $message, messageType: $messageType, receiverId: $receiverId, replyToMessageId: $replyToMessageId)';
  }
}

/// @nodoc
abstract mixin class $MessageRequestDTOCopyWith<$Res> {
  factory $MessageRequestDTOCopyWith(
          MessageRequestDTO value, $Res Function(MessageRequestDTO) _then) =
      _$MessageRequestDTOCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'message_text') String message,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'reply_to_message_id', defaultValue: '')
      String replyToMessageId});
}

/// @nodoc
class _$MessageRequestDTOCopyWithImpl<$Res>
    implements $MessageRequestDTOCopyWith<$Res> {
  _$MessageRequestDTOCopyWithImpl(this._self, this._then);

  final MessageRequestDTO _self;
  final $Res Function(MessageRequestDTO) _then;

  /// Create a copy of MessageRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chatId = null,
    Object? message = null,
    Object? messageType = null,
    Object? receiverId = freezed,
    Object? replyToMessageId = null,
  }) {
    return _then(_self.copyWith(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: freezed == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToMessageId: null == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MessageRequestDTO implements MessageRequestDTO {
  const _MessageRequestDTO(
      {@JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'message_text') required this.message,
      @JsonKey(name: 'message_type') required this.messageType,
      @JsonKey(name: 'receiver_id') this.receiverId,
      @JsonKey(name: 'reply_to_message_id', defaultValue: '')
      required this.replyToMessageId});
  factory _MessageRequestDTO.fromJson(Map<String, dynamic> json) =>
      _$MessageRequestDTOFromJson(json);

  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'message_text')
  final String message;
  @override
  @JsonKey(name: 'message_type')
  final String messageType;
  @override
  @JsonKey(name: 'receiver_id')
  final String? receiverId;
  @override
  @JsonKey(name: 'reply_to_message_id', defaultValue: '')
  final String replyToMessageId;

  /// Create a copy of MessageRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageRequestDTOCopyWith<_MessageRequestDTO> get copyWith =>
      __$MessageRequestDTOCopyWithImpl<_MessageRequestDTO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageRequestDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageRequestDTO &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, chatId, message, messageType, receiverId, replyToMessageId);

  @override
  String toString() {
    return 'MessageRequestDTO(chatId: $chatId, message: $message, messageType: $messageType, receiverId: $receiverId, replyToMessageId: $replyToMessageId)';
  }
}

/// @nodoc
abstract mixin class _$MessageRequestDTOCopyWith<$Res>
    implements $MessageRequestDTOCopyWith<$Res> {
  factory _$MessageRequestDTOCopyWith(
          _MessageRequestDTO value, $Res Function(_MessageRequestDTO) _then) =
      __$MessageRequestDTOCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'message_text') String message,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'receiver_id') String? receiverId,
      @JsonKey(name: 'reply_to_message_id', defaultValue: '')
      String replyToMessageId});
}

/// @nodoc
class __$MessageRequestDTOCopyWithImpl<$Res>
    implements _$MessageRequestDTOCopyWith<$Res> {
  __$MessageRequestDTOCopyWithImpl(this._self, this._then);

  final _MessageRequestDTO _self;
  final $Res Function(_MessageRequestDTO) _then;

  /// Create a copy of MessageRequestDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? chatId = null,
    Object? message = null,
    Object? messageType = null,
    Object? receiverId = freezed,
    Object? replyToMessageId = null,
  }) {
    return _then(_MessageRequestDTO(
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _self.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: freezed == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      replyToMessageId: null == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
