// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'last_message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LastMessageEntity {
  String get id;
  String get chatId;
  String get senderId;
  String get messageText;
  String get messageType;
  bool get isEdited;
  bool get isDeleted;
  DateTime get createdAt;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<LastMessageEntity> get copyWith =>
      _$LastMessageEntityCopyWithImpl<LastMessageEntity>(
          this as LastMessageEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LastMessageEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, senderId,
      messageText, messageType, isEdited, isDeleted, createdAt);

  @override
  String toString() {
    return 'LastMessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LastMessageEntityCopyWith<$Res> {
  factory $LastMessageEntityCopyWith(
          LastMessageEntity value, $Res Function(LastMessageEntity) _then) =
      _$LastMessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      bool isEdited,
      bool isDeleted,
      DateTime createdAt});
}

/// @nodoc
class _$LastMessageEntityCopyWithImpl<$Res>
    implements $LastMessageEntityCopyWith<$Res> {
  _$LastMessageEntityCopyWithImpl(this._self, this._then);

  final LastMessageEntity _self;
  final $Res Function(LastMessageEntity) _then;

  /// Create a copy of LastMessageEntity
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

class _LastMessageEntity extends LastMessageEntity {
  const _LastMessageEntity(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.messageText,
      required this.messageType,
      required this.isEdited,
      required this.isDeleted,
      required this.createdAt})
      : super._();

  @override
  final String id;
  @override
  final String chatId;
  @override
  final String senderId;
  @override
  final String messageText;
  @override
  final String messageType;
  @override
  final bool isEdited;
  @override
  final bool isDeleted;
  @override
  final DateTime createdAt;

  /// Create a copy of LastMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastMessageEntityCopyWith<_LastMessageEntity> get copyWith =>
      __$LastMessageEntityCopyWithImpl<_LastMessageEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LastMessageEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, chatId, senderId,
      messageText, messageType, isEdited, isDeleted, createdAt);

  @override
  String toString() {
    return 'LastMessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LastMessageEntityCopyWith<$Res>
    implements $LastMessageEntityCopyWith<$Res> {
  factory _$LastMessageEntityCopyWith(
          _LastMessageEntity value, $Res Function(_LastMessageEntity) _then) =
      __$LastMessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      bool isEdited,
      bool isDeleted,
      DateTime createdAt});
}

/// @nodoc
class __$LastMessageEntityCopyWithImpl<$Res>
    implements _$LastMessageEntityCopyWith<$Res> {
  __$LastMessageEntityCopyWithImpl(this._self, this._then);

  final _LastMessageEntity _self;
  final $Res Function(_LastMessageEntity) _then;

  /// Create a copy of LastMessageEntity
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
    return _then(_LastMessageEntity(
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
