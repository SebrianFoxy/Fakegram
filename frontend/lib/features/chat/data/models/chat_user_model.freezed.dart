// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatUserModel {
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

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<ChatUserModel> get copyWith =>
      _$ChatUserModelCopyWithImpl<ChatUserModel>(
          this as ChatUserModel, _$identity);

  /// Serializes this ChatUserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatUserModel &&
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
    return 'ChatUserModel(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $ChatUserModelCopyWith<$Res> {
  factory $ChatUserModelCopyWith(
          ChatUserModel value, $Res Function(ChatUserModel) _then) =
      _$ChatUserModelCopyWithImpl;
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
class _$ChatUserModelCopyWithImpl<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  _$ChatUserModelCopyWithImpl(this._self, this._then);

  final ChatUserModel _self;
  final $Res Function(ChatUserModel) _then;

  /// Create a copy of ChatUserModel
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
class _ChatUserModel extends ChatUserModel {
  const _ChatUserModel(
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
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();
  factory _ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);

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

  /// Create a copy of ChatUserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatUserModelCopyWith<_ChatUserModel> get copyWith =>
      __$ChatUserModelCopyWithImpl<_ChatUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatUserModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatUserModel &&
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
    return 'ChatUserModel(id: $id, name: $name, surname: $surname, nickname: $nickname, email: $email, approved: $approved, bio: $bio, avatarUrl: $avatarUrl, isOnline: $isOnline, lastSeen: $lastSeen, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$ChatUserModelCopyWith<$Res>
    implements $ChatUserModelCopyWith<$Res> {
  factory _$ChatUserModelCopyWith(
          _ChatUserModel value, $Res Function(_ChatUserModel) _then) =
      __$ChatUserModelCopyWithImpl;
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
class __$ChatUserModelCopyWithImpl<$Res>
    implements _$ChatUserModelCopyWith<$Res> {
  __$ChatUserModelCopyWithImpl(this._self, this._then);

  final _ChatUserModel _self;
  final $Res Function(_ChatUserModel) _then;

  /// Create a copy of ChatUserModel
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
    return _then(_ChatUserModel(
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
