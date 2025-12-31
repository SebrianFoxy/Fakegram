// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direct_message_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectMessageEntity {
  String get id;
  String get senderId;
  String get receiverId;
  String get text;
  DateTime get createdAt;
  bool get isRead;
  bool get isDelivered;
  bool get isDeleted;

  /// Create a copy of DirectMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectMessageEntityCopyWith<DirectMessageEntity> get copyWith =>
      _$DirectMessageEntityCopyWithImpl<DirectMessageEntity>(
          this as DirectMessageEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DirectMessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, senderId, receiverId, text,
      createdAt, isRead, isDelivered, isDeleted);

  @override
  String toString() {
    return 'DirectMessageEntity(id: $id, senderId: $senderId, receiverId: $receiverId, text: $text, createdAt: $createdAt, isRead: $isRead, isDelivered: $isDelivered, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class $DirectMessageEntityCopyWith<$Res> {
  factory $DirectMessageEntityCopyWith(
          DirectMessageEntity value, $Res Function(DirectMessageEntity) _then) =
      _$DirectMessageEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String senderId,
      String receiverId,
      String text,
      DateTime createdAt,
      bool isRead,
      bool isDelivered,
      bool isDeleted});
}

/// @nodoc
class _$DirectMessageEntityCopyWithImpl<$Res>
    implements $DirectMessageEntityCopyWith<$Res> {
  _$DirectMessageEntityCopyWithImpl(this._self, this._then);

  final DirectMessageEntity _self;
  final $Res Function(DirectMessageEntity) _then;

  /// Create a copy of DirectMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? text = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? isDelivered = null,
    Object? isDeleted = null,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isDelivered: null == isDelivered
          ? _self.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _DirectMessageEntity extends DirectMessageEntity {
  const _DirectMessageEntity(
      {required this.id,
      required this.senderId,
      required this.receiverId,
      required this.text,
      required this.createdAt,
      this.isRead = false,
      this.isDelivered = false,
      this.isDeleted = false})
      : super._();

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  final String text;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isRead;
  @override
  @JsonKey()
  final bool isDelivered;
  @override
  @JsonKey()
  final bool isDeleted;

  /// Create a copy of DirectMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectMessageEntityCopyWith<_DirectMessageEntity> get copyWith =>
      __$DirectMessageEntityCopyWithImpl<_DirectMessageEntity>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DirectMessageEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.isDelivered, isDelivered) ||
                other.isDelivered == isDelivered) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, senderId, receiverId, text,
      createdAt, isRead, isDelivered, isDeleted);

  @override
  String toString() {
    return 'DirectMessageEntity(id: $id, senderId: $senderId, receiverId: $receiverId, text: $text, createdAt: $createdAt, isRead: $isRead, isDelivered: $isDelivered, isDeleted: $isDeleted)';
  }
}

/// @nodoc
abstract mixin class _$DirectMessageEntityCopyWith<$Res>
    implements $DirectMessageEntityCopyWith<$Res> {
  factory _$DirectMessageEntityCopyWith(_DirectMessageEntity value,
          $Res Function(_DirectMessageEntity) _then) =
      __$DirectMessageEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String senderId,
      String receiverId,
      String text,
      DateTime createdAt,
      bool isRead,
      bool isDelivered,
      bool isDeleted});
}

/// @nodoc
class __$DirectMessageEntityCopyWithImpl<$Res>
    implements _$DirectMessageEntityCopyWith<$Res> {
  __$DirectMessageEntityCopyWithImpl(this._self, this._then);

  final _DirectMessageEntity _self;
  final $Res Function(_DirectMessageEntity) _then;

  /// Create a copy of DirectMessageEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? text = null,
    Object? createdAt = null,
    Object? isRead = null,
    Object? isDelivered = null,
    Object? isDeleted = null,
  }) {
    return _then(_DirectMessageEntity(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _self.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      receiverId: null == receiverId
          ? _self.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      isDelivered: null == isDelivered
          ? _self.isDelivered
          : isDelivered // ignore: cast_nullable_to_non_nullable
              as bool,
      isDeleted: null == isDeleted
          ? _self.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
