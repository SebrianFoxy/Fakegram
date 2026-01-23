// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageEntity {
  String get id;
  String get chatId;
  String get senderId;
  String get messageText;
  String get messageType;
  String? get replyToMessageId;
  bool get isEdited;
  bool get isDeleted;
  DateTime get createdAt;
  DateTime? get readAt;
  String get senderName;
  String get senderSurname;
  String get senderNickname;
  String? get senderAvatarUrl;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageEntityCopyWith<MessageEntity> get copyWith =>
      _$MessageEntityCopyWithImpl<MessageEntity>(
          this as MessageEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderSurname, senderSurname) ||
                other.senderSurname == senderSurname) &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      senderId,
      messageText,
      messageType,
      replyToMessageId,
      isEdited,
      isDeleted,
      createdAt,
      readAt,
      senderName,
      senderSurname,
      senderNickname,
      senderAvatarUrl);

  @override
  String toString() {
    return 'MessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt, readAt: $readAt, senderName: $senderName, senderSurname: $senderSurname, senderNickname: $senderNickname, senderAvatarUrl: $senderAvatarUrl)';
  }
}

/// @nodoc
abstract mixin class $MessageEntityCopyWith<$Res> {
  factory $MessageEntityCopyWith(
          MessageEntity value, $Res Function(MessageEntity) _then) =
      _$MessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      String? replyToMessageId,
      bool isEdited,
      bool isDeleted,
      DateTime createdAt,
      DateTime? readAt,
      String senderName,
      String senderSurname,
      String senderNickname,
      String? senderAvatarUrl});
}

/// @nodoc
class _$MessageEntityCopyWithImpl<$Res>
    implements $MessageEntityCopyWith<$Res> {
  _$MessageEntityCopyWithImpl(this._self, this._then);

  final MessageEntity _self;
  final $Res Function(MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? replyToMessageId = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? senderName = null,
    Object? senderSurname = null,
    Object? senderNickname = null,
    Object? senderAvatarUrl = freezed,
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
      replyToMessageId: freezed == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderSurname: null == senderSurname
          ? _self.senderSurname
          : senderSurname // ignore: cast_nullable_to_non_nullable
              as String,
      senderNickname: null == senderNickname
          ? _self.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatarUrl: freezed == senderAvatarUrl
          ? _self.senderAvatarUrl
          : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _MessageEntity extends MessageEntity {
  const _MessageEntity(
      {required this.id,
      required this.chatId,
      required this.senderId,
      required this.messageText,
      required this.messageType,
      required this.replyToMessageId,
      required this.isEdited,
      required this.isDeleted,
      required this.createdAt,
      required this.readAt,
      required this.senderName,
      required this.senderSurname,
      required this.senderNickname,
      required this.senderAvatarUrl})
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
  final String? replyToMessageId;
  @override
  final bool isEdited;
  @override
  final bool isDeleted;
  @override
  final DateTime createdAt;
  @override
  final DateTime? readAt;
  @override
  final String senderName;
  @override
  final String senderSurname;
  @override
  final String senderNickname;
  @override
  final String? senderAvatarUrl;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageEntityCopyWith<_MessageEntity> get copyWith =>
      __$MessageEntityCopyWithImpl<_MessageEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatId, chatId) || other.chatId == chatId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.messageText, messageText) ||
                other.messageText == messageText) &&
            (identical(other.messageType, messageType) ||
                other.messageType == messageType) &&
            (identical(other.replyToMessageId, replyToMessageId) ||
                other.replyToMessageId == replyToMessageId) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.senderSurname, senderSurname) ||
                other.senderSurname == senderSurname) &&
            (identical(other.senderNickname, senderNickname) ||
                other.senderNickname == senderNickname) &&
            (identical(other.senderAvatarUrl, senderAvatarUrl) ||
                other.senderAvatarUrl == senderAvatarUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      chatId,
      senderId,
      messageText,
      messageType,
      replyToMessageId,
      isEdited,
      isDeleted,
      createdAt,
      readAt,
      senderName,
      senderSurname,
      senderNickname,
      senderAvatarUrl);

  @override
  String toString() {
    return 'MessageEntity(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt, readAt: $readAt, senderName: $senderName, senderSurname: $senderSurname, senderNickname: $senderNickname, senderAvatarUrl: $senderAvatarUrl)';
  }
}

/// @nodoc
abstract mixin class _$MessageEntityCopyWith<$Res>
    implements $MessageEntityCopyWith<$Res> {
  factory _$MessageEntityCopyWith(
          _MessageEntity value, $Res Function(_MessageEntity) _then) =
      __$MessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String chatId,
      String senderId,
      String messageText,
      String messageType,
      String? replyToMessageId,
      bool isEdited,
      bool isDeleted,
      DateTime createdAt,
      DateTime? readAt,
      String senderName,
      String senderSurname,
      String senderNickname,
      String? senderAvatarUrl});
}

/// @nodoc
class __$MessageEntityCopyWithImpl<$Res>
    implements _$MessageEntityCopyWith<$Res> {
  __$MessageEntityCopyWithImpl(this._self, this._then);

  final _MessageEntity _self;
  final $Res Function(_MessageEntity) _then;

  /// Create a copy of MessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? chatId = null,
    Object? senderId = null,
    Object? messageText = null,
    Object? messageType = null,
    Object? replyToMessageId = freezed,
    Object? isEdited = null,
    Object? isDeleted = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? senderName = null,
    Object? senderSurname = null,
    Object? senderNickname = null,
    Object? senderAvatarUrl = freezed,
  }) {
    return _then(_MessageEntity(
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
      replyToMessageId: freezed == replyToMessageId
          ? _self.replyToMessageId
          : replyToMessageId // ignore: cast_nullable_to_non_nullable
              as String?,
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
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      senderName: null == senderName
          ? _self.senderName
          : senderName // ignore: cast_nullable_to_non_nullable
              as String,
      senderSurname: null == senderSurname
          ? _self.senderSurname
          : senderSurname // ignore: cast_nullable_to_non_nullable
              as String,
      senderNickname: null == senderNickname
          ? _self.senderNickname
          : senderNickname // ignore: cast_nullable_to_non_nullable
              as String,
      senderAvatarUrl: freezed == senderAvatarUrl
          ? _self.senderAvatarUrl
          : senderAvatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
