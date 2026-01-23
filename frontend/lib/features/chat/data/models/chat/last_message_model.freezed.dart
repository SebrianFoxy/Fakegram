// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LastMessageModel {
  String get id;
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'sender_id')
  String get senderId;
  @JsonKey(name: 'message_text')
  String get messageText;
  @JsonKey(name: 'message_type')
  String get messageType;
  @JsonKey(name: 'is_edited')
  bool get isEdited;
  @JsonKey(name: 'is_deleted')
  bool get isDeleted;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastMessageModelCopyWith<LastMessageModel> get copyWith =>
      _$LastMessageModelCopyWithImpl<LastMessageModel>(
          this as LastMessageModel, _$identity);

  /// Serializes this LastMessageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LastMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, senderId,
      messageText, messageType, isEdited, isDeleted, createdAt);

  @override
  String toString() {
    return 'LastMessageModel(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LastMessageModelCopyWith<$Res> {
  factory $LastMessageModelCopyWith(
          LastMessageModel value, $Res Function(LastMessageModel) _then) =
      _$LastMessageModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'message_text') String messageText,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'is_edited') bool isEdited,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class _$LastMessageModelCopyWithImpl<$Res>
    implements $LastMessageModelCopyWith<$Res> {
  _$LastMessageModelCopyWithImpl(this._self, this._then);

  final LastMessageModel _self;
  final $Res Function(LastMessageModel) _then;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _self.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LastMessageModel extends LastMessageModel {
  const _LastMessageModel(
      {required this.id,
      @JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'sender_id') required this.senderId,
      @JsonKey(name: 'message_text') required this.messageText,
      @JsonKey(name: 'message_type') required this.messageType,
      @JsonKey(name: 'is_edited') required this.isEdited,
      @JsonKey(name: 'is_deleted') required this.isDeleted,
      @JsonKey(name: 'created_at') required this.createdAt})
      : super._();
  factory _LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'chat_id')
  final String chatId;
  @override
  @JsonKey(name: 'sender_id')
  final String senderId;
  @override
  @JsonKey(name: 'message_text')
  final String messageText;
  @override
  @JsonKey(name: 'message_type')
  final String messageType;
  @override
  @JsonKey(name: 'is_edited')
  final bool isEdited;
  @override
  @JsonKey(name: 'is_deleted')
  final bool isDeleted;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastMessageModelCopyWith<_LastMessageModel> get copyWith =>
      __$LastMessageModelCopyWithImpl<_LastMessageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LastMessageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LastMessageModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, senderId,
      messageText, messageType, isEdited, isDeleted, createdAt);

  @override
  String toString() {
    return 'LastMessageModel(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LastMessageModelCopyWith<$Res>
    implements $LastMessageModelCopyWith<$Res> {
  factory _$LastMessageModelCopyWith(
          _LastMessageModel value, $Res Function(_LastMessageModel) _then) =
      __$LastMessageModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'message_text') String messageText,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'is_edited') bool isEdited,
      @JsonKey(name: 'is_deleted') bool isDeleted,
      @JsonKey(name: 'created_at') DateTime createdAt});
}

/// @nodoc
class __$LastMessageModelCopyWithImpl<$Res>
    implements _$LastMessageModelCopyWith<$Res> {
  __$LastMessageModelCopyWithImpl(this._self, this._then);

  final _LastMessageModel _self;
  final $Res Function(_LastMessageModel) _then;

  /// Create a copy of LastMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = null,
  }) {
    return _then(_LastMessageModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatId: null == chatId
          ? _self.chatId
          : chatId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      messageText: null == messageText
          ? _self.messageText
          : messageText // ignore: cast_nullable_to_non_nullable
              as String,
      messageType: null == messageType
          ? _self.messageType
          : messageType // ignore: cast_nullable_to_non_nullable
              as String,
      isEdited: null == isEdited
          ? _self.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
