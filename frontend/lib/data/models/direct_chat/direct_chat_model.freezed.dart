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
  String get otherUserId;
  String get otherUserName;
  String get otherUserAvatar;
  String get lastMessage;
  String get lastMessageTime;
  int get unreadCount;
  bool get isOnline;
  DateTime? get createdAt;

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
            (identical(other.otherUserId, otherUserId) ||
                other.otherUserId == otherUserId) &&
            (identical(other.otherUserName, otherUserName) ||
                other.otherUserName == otherUserName) &&
            (identical(other.otherUserAvatar, otherUserAvatar) ||
                other.otherUserAvatar == otherUserAvatar) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      otherUserId,
      otherUserName,
      otherUserAvatar,
      lastMessage,
      lastMessageTime,
      unreadCount,
      isOnline,
      createdAt);

  @override
  String toString() {
    return 'DirectChatModel(id: $id, otherUserId: $otherUserId, otherUserName: $otherUserName, otherUserAvatar: $otherUserAvatar, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, isOnline: $isOnline, createdAt: $createdAt)';
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
      String otherUserId,
      String otherUserName,
      String otherUserAvatar,
      String lastMessage,
      String lastMessageTime,
      int unreadCount,
      bool isOnline,
      DateTime? createdAt});
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
    Object? otherUserId = null,
    Object? otherUserName = null,
    Object? otherUserAvatar = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
    Object? isOnline = null,
    Object? createdAt = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserId: null == otherUserId
          ? _self.otherUserId
          : otherUserId // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserName: null == otherUserName
          ? _self.otherUserName
          : otherUserName // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserAvatar: null == otherUserAvatar
          ? _self.otherUserAvatar
          : otherUserAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _DirectChatModel implements DirectChatModel {
  const _DirectChatModel(
      {required this.id,
      required this.otherUserId,
      required this.otherUserName,
      required this.otherUserAvatar,
      required this.lastMessage,
      required this.lastMessageTime,
      this.unreadCount = 0,
      required this.isOnline,
      this.createdAt});
  factory _DirectChatModel.fromJson(Map<String, dynamic> json) =>
      _$DirectChatModelFromJson(json);

  @override
  final String id;
  @override
  final String otherUserId;
  @override
  final String otherUserName;
  @override
  final String otherUserAvatar;
  @override
  final String lastMessage;
  @override
  final String lastMessageTime;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final bool isOnline;
  @override
  final DateTime? createdAt;

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
            (identical(other.otherUserId, otherUserId) ||
                other.otherUserId == otherUserId) &&
            (identical(other.otherUserName, otherUserName) ||
                other.otherUserName == otherUserName) &&
            (identical(other.otherUserAvatar, otherUserAvatar) ||
                other.otherUserAvatar == otherUserAvatar) &&
            (identical(other.lastMessage, lastMessage) ||
                other.lastMessage == lastMessage) &&
            (identical(other.lastMessageTime, lastMessageTime) ||
                other.lastMessageTime == lastMessageTime) &&
            (identical(other.unreadCount, unreadCount) ||
                other.unreadCount == unreadCount) &&
            (identical(other.isOnline, isOnline) ||
                other.isOnline == isOnline) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      otherUserId,
      otherUserName,
      otherUserAvatar,
      lastMessage,
      lastMessageTime,
      unreadCount,
      isOnline,
      createdAt);

  @override
  String toString() {
    return 'DirectChatModel(id: $id, otherUserId: $otherUserId, otherUserName: $otherUserName, otherUserAvatar: $otherUserAvatar, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, unreadCount: $unreadCount, isOnline: $isOnline, createdAt: $createdAt)';
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
      String otherUserId,
      String otherUserName,
      String otherUserAvatar,
      String lastMessage,
      String lastMessageTime,
      int unreadCount,
      bool isOnline,
      DateTime? createdAt});
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
    Object? otherUserId = null,
    Object? otherUserName = null,
    Object? otherUserAvatar = null,
    Object? lastMessage = null,
    Object? lastMessageTime = null,
    Object? unreadCount = null,
    Object? isOnline = null,
    Object? createdAt = freezed,
  }) {
    return _then(_DirectChatModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserId: null == otherUserId
          ? _self.otherUserId
          : otherUserId // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserName: null == otherUserName
          ? _self.otherUserName
          : otherUserName // ignore: cast_nullable_to_non_nullable
              as String,
      otherUserAvatar: null == otherUserAvatar
          ? _self.otherUserAvatar
          : otherUserAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessage: null == lastMessage
          ? _self.lastMessage
          : lastMessage // ignore: cast_nullable_to_non_nullable
              as String,
      lastMessageTime: null == lastMessageTime
          ? _self.lastMessageTime
          : lastMessageTime // ignore: cast_nullable_to_non_nullable
              as String,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      isOnline: null == isOnline
          ? _self.isOnline
          : isOnline // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: freezed == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
