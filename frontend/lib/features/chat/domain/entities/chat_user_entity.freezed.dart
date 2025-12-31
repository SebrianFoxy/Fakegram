// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatUserEntity {
  String get id;
  String get name;
  String get surname;
  String get nickname;
  String get email;
  bool get approved;
  String? get bio;
  String? get avatarUrl;
  bool get isOnline;
  DateTime get lastSeen;
  DateTime get createdAt;
  DateTime get updatedAt;

  /// Create a copy of ChatUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatUserEntityCopyWith<ChatUserEntity> get copyWith =>
      _$ChatUserEntityCopyWithImpl<ChatUserEntity>(
          this as ChatUserEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatUserEntity &&
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
    return 'ChatUserEntity(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ChatUserEntityCopyWith<$Res> {
  factory $ChatUserEntityCopyWith(
          ChatUserEntity value, $Res Function(ChatUserEntity) _then) =
      _$ChatUserEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String name,
      String surname,
      String nickname,
      String email,
      bool approved,
      String? bio,
      String? avatarUrl,
      bool isOnline,
      DateTime lastSeen,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ChatUserEntityCopyWithImpl<$Res>
    implements $ChatUserEntityCopyWith<$Res> {
  _$ChatUserEntityCopyWithImpl(this._self, this._then);

  final ChatUserEntity _self;
  final $Res Function(ChatUserEntity) _then;

  /// Create a copy of ChatUserEntity
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

class _ChatUserEntity extends ChatUserEntity {
  const _ChatUserEntity(
      {required this.id,
      required this.name,
      required this.surname,
      required this.nickname,
      required this.email,
      required this.approved,
      required this.bio,
      required this.avatarUrl,
      required this.isOnline,
      required this.lastSeen,
      required this.createdAt,
      required this.updatedAt})
      : super._();

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
  final String? avatarUrl;
  @override
  final bool isOnline;
  @override
  final DateTime lastSeen;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  /// Create a copy of ChatUserEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatUserEntityCopyWith<_ChatUserEntity> get copyWith =>
      __$ChatUserEntityCopyWithImpl<_ChatUserEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatUserEntity &&
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
    return 'ChatUserEntity(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ChatUserEntityCopyWith<$Res>
    implements $ChatUserEntityCopyWith<$Res> {
  factory _$ChatUserEntityCopyWith(
          _ChatUserEntity value, $Res Function(_ChatUserEntity) _then) =
      __$ChatUserEntityCopyWithImpl;
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
      String? avatarUrl,
      bool isOnline,
      DateTime lastSeen,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$ChatUserEntityCopyWithImpl<$Res>
    implements _$ChatUserEntityCopyWith<$Res> {
  __$ChatUserEntityCopyWithImpl(this._self, this._then);

  final _ChatUserEntity _self;
  final $Res Function(_ChatUserEntity) _then;

  /// Create a copy of ChatUserEntity
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
    return _then(_ChatUserEntity(
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
