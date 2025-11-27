// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direct_chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectChatModel {
  String get id;
  @JsonKey(name: 'chat_type')
  String get chatType;
  String get title;
  @JsonKey(name: 'last_message')
  LastMessage get lastMessage;
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @JsonKey(name: 'other_user')
  ChatUser get otherUser;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectChatModelCopyWith<DirectChatModel> get copyWith =>
      _$DirectChatModelCopyWithImpl<DirectChatModel>(
          this as DirectChatModel, _$identity);

  /// Serializes this DirectChatModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DirectChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.otherUser, otherUser) ||
                other.otherUser == otherUser) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatType, title, lastMessage,
      unreadCount, otherUser, updatedAt);

  @override
  String toString() {
    return 'DirectChatModel(id: $id, chatType: $chatType, title: $title, lastMessage: $lastMessage, unreadCount: $unreadCount, otherUser: $otherUser, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $DirectChatModelCopyWith<$Res> {
  factory $DirectChatModelCopyWith(
          DirectChatModel value, $Res Function(DirectChatModel) _then) =
      _$DirectChatModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_type') String chatType,
      String title,
      @JsonKey(name: 'last_message') LastMessage lastMessage,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'other_user') ChatUser otherUser,
      @JsonKey(name: 'updated_at') DateTime updatedAt});

  $LastMessageCopyWith<$Res> get lastMessage;
  $ChatUserCopyWith<$Res> get otherUser;
}

/// @nodoc
class _$DirectChatModelCopyWithImpl<$Res>
    implements $DirectChatModelCopyWith<$Res> {
  _$DirectChatModelCopyWithImpl(this._self, this._then);

  final DirectChatModel _self;
  final $Res Function(DirectChatModel) _then;

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? chatType = null,
    Object? title = null,
    Object? lastMessage = null,
    Object? unreadCount = null,
    Object? otherUser = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatType: null == chatType
          ? _self.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessage,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUser,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageCopyWith<$Res> get lastMessage {
    return $LastMessageCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserCopyWith<$Res> get otherUser {
    return $ChatUserCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// @nodoc
@JsonSerializable()
class _DirectChatModel implements DirectChatModel {
  const _DirectChatModel(
      {required this.id,
      @JsonKey(name: 'chat_type') required this.chatType,
      required this.title,
      @JsonKey(name: 'last_message') required this.lastMessage,
      @JsonKey(name: 'unread_count') this.unreadCount = 0,
      @JsonKey(name: 'other_user') required this.otherUser,
      @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _DirectChatModel.fromJson(Map<String, dynamic> json) =>
      _$DirectChatModelFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'chat_type')
  final String chatType;
  @override
  final String title;
  @override
  @JsonKey(name: 'last_message')
  final LastMessage lastMessage;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'other_user')
  final ChatUser otherUser;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectChatModelCopyWith<_DirectChatModel> get copyWith =>
      __$DirectChatModelCopyWithImpl<_DirectChatModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DirectChatModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DirectChatModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.chatType, chatType) ||
                other.chatType == chatType) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.otherUser, otherUser) ||
                other.otherUser == otherUser) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, chatType, title, lastMessage,
      unreadCount, otherUser, updatedAt);

  @override
  String toString() {
    return 'DirectChatModel(id: $id, chatType: $chatType, title: $title, lastMessage: $lastMessage, unreadCount: $unreadCount, otherUser: $otherUser, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$DirectChatModelCopyWith<$Res>
    implements $DirectChatModelCopyWith<$Res> {
  factory _$DirectChatModelCopyWith(
          _DirectChatModel value, $Res Function(_DirectChatModel) _then) =
      __$DirectChatModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_type') String chatType,
      String title,
      @JsonKey(name: 'last_message') LastMessage lastMessage,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'other_user') ChatUser otherUser,
      @JsonKey(name: 'updated_at') DateTime updatedAt});

  @override
  $LastMessageCopyWith<$Res> get lastMessage;
  @override
  $ChatUserCopyWith<$Res> get otherUser;
}

/// @nodoc
class __$DirectChatModelCopyWithImpl<$Res>
    implements _$DirectChatModelCopyWith<$Res> {
  __$DirectChatModelCopyWithImpl(this._self, this._then);

  final _DirectChatModel _self;
  final $Res Function(_DirectChatModel) _then;

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? chatType = null,
    Object? title = null,
    Object? lastMessage = null,
    Object? unreadCount = null,
    Object? otherUser = null,
    Object? updatedAt = null,
  }) {
    return _then(_DirectChatModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      chatType: null == chatType
          ? _self.chatType
          : chatType // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as LastMessage,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUser,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageCopyWith<$Res> get lastMessage {
    return $LastMessageCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserCopyWith<$Res> get otherUser {
    return $ChatUserCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// @nodoc
mixin _$LastMessage {
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

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LastMessageCopyWith<LastMessage> get copyWith =>
      _$LastMessageCopyWithImpl<LastMessage>(this as LastMessage, _$identity);

  /// Serializes this LastMessage to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LastMessage &&
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
    return 'LastMessage(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class $LastMessageCopyWith<$Res> {
  factory $LastMessageCopyWith(
          LastMessage value, $Res Function(LastMessage) _then) =
      _$LastMessageCopyWithImpl;
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
class _$LastMessageCopyWithImpl<$Res> implements $LastMessageCopyWith<$Res> {
  _$LastMessageCopyWithImpl(this._self, this._then);

  final LastMessage _self;
  final $Res Function(LastMessage) _then;

  /// Create a copy of LastMessage
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
class _LastMessage implements LastMessage {
  const _LastMessage(
      {required this.id,
      @JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'sender_id') required this.senderId,
      @JsonKey(name: 'message_text') required this.messageText,
      @JsonKey(name: 'message_type') required this.messageType,
      @JsonKey(name: 'is_edited') required this.isEdited,
      @JsonKey(name: 'is_deleted') required this.isDeleted,
      @JsonKey(name: 'created_at') required this.createdAt});
  factory _LastMessage.fromJson(Map<String, dynamic> json) =>
      _$LastMessageFromJson(json);

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

  /// Create a copy of LastMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LastMessageCopyWith<_LastMessage> get copyWith =>
      __$LastMessageCopyWithImpl<_LastMessage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LastMessageToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LastMessage &&
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
    return 'LastMessage(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, isEdited: $isEdited, isDeleted: $isDeleted, createdAt: $createdAt)';
  }
}

/// @nodoc
abstract mixin class _$LastMessageCopyWith<$Res>
    implements $LastMessageCopyWith<$Res> {
  factory _$LastMessageCopyWith(
          _LastMessage value, $Res Function(_LastMessage) _then) =
      __$LastMessageCopyWithImpl;
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
class __$LastMessageCopyWithImpl<$Res> implements _$LastMessageCopyWith<$Res> {
  __$LastMessageCopyWithImpl(this._self, this._then);

  final _LastMessage _self;
  final $Res Function(_LastMessage) _then;

  /// Create a copy of LastMessage
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
    return _then(_LastMessage(
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
mixin _$ChatUser {
  String get id;
  String get name;
  String get surname;
  String get nickname;
  String get email;
  bool get approved;
  String? get bio;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @JsonKey(name: 'is_online')
  bool get isOnline;
  @JsonKey(name: 'last_seen')
  DateTime get lastSeen;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatUserCopyWith<ChatUser> get copyWith =>
      _$ChatUserCopyWithImpl<ChatUser>(this as ChatUser, _$identity);

  /// Serializes this ChatUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      surname,
      nickname,
      email,
      approved,
      bio,
      avatarUrl,
      isOnline,
      lastSeen,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'ChatUser(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ChatUserCopyWith<$Res> {
  factory $ChatUserCopyWith(ChatUser value, $Res Function(ChatUser) _then) =
      _$ChatUserCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String nickname,
      String email,
      bool approved,
      String? bio,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'is_online') bool isOnline,
      @JsonKey(name: 'last_seen') DateTime lastSeen,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class _$ChatUserCopyWithImpl<$Res> implements $ChatUserCopyWith<$Res> {
  _$ChatUserCopyWithImpl(this._self, this._then);

  final ChatUser _self;
  final $Res Function(ChatUser) _then;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? email = null,
    Object? approved = null,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: null == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _ChatUser implements ChatUser {
  const _ChatUser(
      {required this.id,
      required this.name,
      required this.surname,
      required this.nickname,
      required this.email,
      required this.approved,
      required this.bio,
      @JsonKey(name: 'avatar_url') required this.avatarUrl,
      @JsonKey(name: 'is_online') required this.isOnline,
      @JsonKey(name: 'last_seen') required this.lastSeen,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _ChatUser.fromJson(Map<String, dynamic> json) =>
      _$ChatUserFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String surname;
  @override
  final String nickname;
  @override
  final String email;
  @override
  final bool approved;
  @override
  final String? bio;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'is_online')
  final bool isOnline;
  @override
  @JsonKey(name: 'last_seen')
  final DateTime lastSeen;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatUserCopyWith<_ChatUser> get copyWith =>
      __$ChatUserCopyWithImpl<_ChatUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatUser &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.approved, approved) ||
                other.approved == approved) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.lastSeen, lastSeen) ||
                other.lastSeen == lastSeen) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      surname,
      nickname,
      email,
      approved,
      bio,
      avatarUrl,
      isOnline,
      lastSeen,
      createdAt,
      updatedAt);

  @override
  String toString() {
    return 'ChatUser(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ChatUserCopyWith<$Res>
    implements $ChatUserCopyWith<$Res> {
  factory _$ChatUserCopyWith(_ChatUser value, $Res Function(_ChatUser) _then) =
      __$ChatUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String nickname,
      String email,
      bool approved,
      String? bio,
      @JsonKey(name: 'avatar_url') String? avatarUrl,
      @JsonKey(name: 'is_online') bool isOnline,
      @JsonKey(name: 'last_seen') DateTime lastSeen,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'updated_at') DateTime updatedAt});
}

/// @nodoc
class __$ChatUserCopyWithImpl<$Res> implements _$ChatUserCopyWith<$Res> {
  __$ChatUserCopyWithImpl(this._self, this._then);

  final _ChatUser _self;
  final $Res Function(_ChatUser) _then;

  /// Create a copy of ChatUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? email = null,
    Object? approved = null,
    Object? bio = freezed,
    Object? avatarUrl = freezed,
    Object? isOnline = null,
    Object? lastSeen = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_ChatUser(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      surname: null == surname
          ? _self.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _self.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      approved: null == approved
          ? _self.approved
          : approved // ignore: cast_nullable_to_non_nullable
              as bool,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      lastSeen: null == lastSeen
          ? _self.lastSeen
          : lastSeen // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

// dart format on
