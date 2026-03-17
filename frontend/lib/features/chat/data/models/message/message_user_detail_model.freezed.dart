// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_user_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageUserDetailModel {
  @JsonKey(name: 'name')
  String get name;
  @JsonKey(name: 'surname')
  String get surname;
  @JsonKey(name: 'nickname')
  String get nickname;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;

  /// Create a copy of MessageUserDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageUserDetailModelCopyWith<MessageUserDetailModel> get copyWith =>
      _$MessageUserDetailModelCopyWithImpl<MessageUserDetailModel>(
          this as MessageUserDetailModel, _$identity);

  /// Serializes this MessageUserDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageUserDetailModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, surname, nickname, avatarUrl);

  @override
  String toString() {
    return 'MessageUserDetailModel(name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl)';
  }
}

/// @nodoc
abstract mixin class $MessageUserDetailModelCopyWith<$Res> {
  factory $MessageUserDetailModelCopyWith(MessageUserDetailModel value,
          $Res Function(MessageUserDetailModel) _then) =
      _$MessageUserDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'avatar_url') String? avatarUrl});
}

/// @nodoc
class _$MessageUserDetailModelCopyWithImpl<$Res>
    implements $MessageUserDetailModelCopyWith<$Res> {
  _$MessageUserDetailModelCopyWithImpl(this._self, this._then);

  final MessageUserDetailModel _self;
  final $Res Function(MessageUserDetailModel) _then;

  /// Create a copy of MessageUserDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_self.copyWith(
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
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _MessageUserDetailModel implements MessageUserDetailModel {
  const _MessageUserDetailModel(
      {@JsonKey(name: 'name') required this.name,
      @JsonKey(name: 'surname') required this.surname,
      @JsonKey(name: 'nickname') required this.nickname,
      @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _MessageUserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MessageUserDetailModelFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String name;
  @override
  @JsonKey(name: 'surname')
  final String surname;
  @override
  @JsonKey(name: 'nickname')
  final String nickname;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  /// Create a copy of MessageUserDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageUserDetailModelCopyWith<_MessageUserDetailModel> get copyWith =>
      __$MessageUserDetailModelCopyWithImpl<_MessageUserDetailModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageUserDetailModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageUserDetailModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.surname, surname) || other.surname == surname) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, surname, nickname, avatarUrl);

  @override
  String toString() {
    return 'MessageUserDetailModel(name: $name, surname: $surname, nickname: $nickname, avatarUrl: $avatarUrl)';
  }
}

/// @nodoc
abstract mixin class _$MessageUserDetailModelCopyWith<$Res>
    implements $MessageUserDetailModelCopyWith<$Res> {
  factory _$MessageUserDetailModelCopyWith(_MessageUserDetailModel value,
          $Res Function(_MessageUserDetailModel) _then) =
      __$MessageUserDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String name,
      @JsonKey(name: 'surname') String surname,
      @JsonKey(name: 'nickname') String nickname,
      @JsonKey(name: 'avatar_url') String? avatarUrl});
}

/// @nodoc
class __$MessageUserDetailModelCopyWithImpl<$Res>
    implements _$MessageUserDetailModelCopyWith<$Res> {
  __$MessageUserDetailModelCopyWithImpl(this._self, this._then);

  final _MessageUserDetailModel _self;
  final $Res Function(_MessageUserDetailModel) _then;

  /// Create a copy of MessageUserDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? name = null,
    Object? surname = null,
    Object? nickname = null,
    Object? avatarUrl = freezed,
  }) {
    return _then(_MessageUserDetailModel(
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
      avatarUrl: freezed == avatarUrl
          ? _self.avatarUrl
          : avatarUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
