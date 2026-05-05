// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'direct_chat_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DirectChatEntity {
  String get id;
  String get chatType;
  String get title;
  LastMessageEntity get lastMessage;
  int get unreadCount;
  ChatUserEntity get otherUser;
  DateTime get updatedAt;

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DirectChatEntityCopyWith<DirectChatEntity> get copyWith =>
      _$DirectChatEntityCopyWithImpl<DirectChatEntity>(
          this as DirectChatEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DirectChatEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, chatType, title, lastMessage,
      unreadCount, otherUser, updatedAt);

  @override
  String toString() {
    return 'DirectChatEntity(id: $id, chatType: $chatType, title: $title, lastMessage: $lastMessage, unreadCount: $unreadCount, otherUser: $otherUser, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class $DirectChatEntityCopyWith<$Res> {
  factory $DirectChatEntityCopyWith(
          DirectChatEntity value, $Res Function(DirectChatEntity) _then) =
      _$DirectChatEntityCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String chatType,
      String title,
      LastMessageEntity lastMessage,
      int unreadCount,
      ChatUserEntity otherUser,
      DateTime updatedAt});

  $LastMessageEntityCopyWith<$Res> get lastMessage;
  $ChatUserEntityCopyWith<$Res> get otherUser;
}

/// @nodoc
class _$DirectChatEntityCopyWithImpl<$Res>
    implements $DirectChatEntityCopyWith<$Res> {
  _$DirectChatEntityCopyWithImpl(this._self, this._then);

  final DirectChatEntity _self;
  final $Res Function(DirectChatEntity) _then;

  /// Create a copy of DirectChatEntity
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
              as LastMessageEntity,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUserEntity,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<$Res> get lastMessage {
    return $LastMessageEntityCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserEntityCopyWith<$Res> get otherUser {
    return $ChatUserEntityCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DirectChatEntity].
extension DirectChatEntityPatterns on DirectChatEntity {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_DirectChatEntity value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_DirectChatEntity value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_DirectChatEntity value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            String chatType,
            String title,
            LastMessageEntity lastMessage,
            int unreadCount,
            ChatUserEntity otherUser,
            DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity() when $default != null:
        return $default(
            _that.id,
            _that.chatType,
            _that.title,
            _that.lastMessage,
            _that.unreadCount,
            _that.otherUser,
            _that.updatedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            String chatType,
            String title,
            LastMessageEntity lastMessage,
            int unreadCount,
            ChatUserEntity otherUser,
            DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity():
        return $default(
            _that.id,
            _that.chatType,
            _that.title,
            _that.lastMessage,
            _that.unreadCount,
            _that.otherUser,
            _that.updatedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String chatType,
            String title,
            LastMessageEntity lastMessage,
            int unreadCount,
            ChatUserEntity otherUser,
            DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatEntity() when $default != null:
        return $default(
            _that.id,
            _that.chatType,
            _that.title,
            _that.lastMessage,
            _that.unreadCount,
            _that.otherUser,
            _that.updatedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DirectChatEntity extends DirectChatEntity {
  const _DirectChatEntity(
      {required this.id,
      required this.chatType,
      required this.title,
      required this.lastMessage,
      this.unreadCount = 0,
      required this.otherUser,
      required this.updatedAt})
      : super._();

  @override
  final String id;
  @override
  final String chatType;
  @override
  final String title;
  @override
  final LastMessageEntity lastMessage;
  @override
  @JsonKey()
  final int unreadCount;
  @override
  final ChatUserEntity otherUser;
  @override
  final DateTime updatedAt;

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DirectChatEntityCopyWith<_DirectChatEntity> get copyWith =>
      __$DirectChatEntityCopyWithImpl<_DirectChatEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DirectChatEntity &&
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

  @override
  int get hashCode => Object.hash(runtimeType, id, chatType, title, lastMessage,
      unreadCount, otherUser, updatedAt);

  @override
  String toString() {
    return 'DirectChatEntity(id: $id, chatType: $chatType, title: $title, lastMessage: $lastMessage, unreadCount: $unreadCount, otherUser: $otherUser, updatedAt: $updatedAt)';
  }
}

/// @nodoc
abstract mixin class _$DirectChatEntityCopyWith<$Res>
    implements $DirectChatEntityCopyWith<$Res> {
  factory _$DirectChatEntityCopyWith(
          _DirectChatEntity value, $Res Function(_DirectChatEntity) _then) =
      __$DirectChatEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String chatType,
      String title,
      LastMessageEntity lastMessage,
      int unreadCount,
      ChatUserEntity otherUser,
      DateTime updatedAt});

  @override
  $LastMessageEntityCopyWith<$Res> get lastMessage;
  @override
  $ChatUserEntityCopyWith<$Res> get otherUser;
}

/// @nodoc
class __$DirectChatEntityCopyWithImpl<$Res>
    implements _$DirectChatEntityCopyWith<$Res> {
  __$DirectChatEntityCopyWithImpl(this._self, this._then);

  final _DirectChatEntity _self;
  final $Res Function(_DirectChatEntity) _then;

  /// Create a copy of DirectChatEntity
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
    return _then(_DirectChatEntity(
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
              as LastMessageEntity,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUserEntity,
      updatedAt: null == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LastMessageEntityCopyWith<$Res> get lastMessage {
    return $LastMessageEntityCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserEntityCopyWith<$Res> get otherUser {
    return $ChatUserEntityCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

// dart format on
