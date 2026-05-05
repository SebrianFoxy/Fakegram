// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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
  LastMessageModel get lastMessage;
  @JsonKey(name: 'unread_count')
  int get unreadCount;
  @JsonKey(name: 'other_user')
  ChatUserModel get otherUser;
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
      @JsonKey(name: 'last_message') LastMessageModel lastMessage,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'other_user') ChatUserModel otherUser,
      @JsonKey(name: 'updated_at') DateTime updatedAt});

  $LastMessageModelCopyWith<$Res> get lastMessage;
  $ChatUserModelCopyWith<$Res> get otherUser;
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
              as LastMessageModel,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUserModel,
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
  $LastMessageModelCopyWith<$Res> get lastMessage {
    return $LastMessageModelCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res> get otherUser {
    return $ChatUserModelCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DirectChatModel].
extension DirectChatModelPatterns on DirectChatModel {
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
    TResult Function(_DirectChatModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel() when $default != null:
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
    TResult Function(_DirectChatModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel():
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
    TResult? Function(_DirectChatModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel() when $default != null:
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
            @JsonKey(name: 'chat_type') String chatType,
            String title,
            @JsonKey(name: 'last_message') LastMessageModel lastMessage,
            @JsonKey(name: 'unread_count') int unreadCount,
            @JsonKey(name: 'other_user') ChatUserModel otherUser,
            @JsonKey(name: 'updated_at') DateTime updatedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel() when $default != null:
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
            @JsonKey(name: 'chat_type') String chatType,
            String title,
            @JsonKey(name: 'last_message') LastMessageModel lastMessage,
            @JsonKey(name: 'unread_count') int unreadCount,
            @JsonKey(name: 'other_user') ChatUserModel otherUser,
            @JsonKey(name: 'updated_at') DateTime updatedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel():
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
            @JsonKey(name: 'chat_type') String chatType,
            String title,
            @JsonKey(name: 'last_message') LastMessageModel lastMessage,
            @JsonKey(name: 'unread_count') int unreadCount,
            @JsonKey(name: 'other_user') ChatUserModel otherUser,
            @JsonKey(name: 'updated_at') DateTime updatedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DirectChatModel() when $default != null:
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
@JsonSerializable()
class _DirectChatModel extends DirectChatModel {
  const _DirectChatModel(
      {required this.id,
      @JsonKey(name: 'chat_type') required this.chatType,
      required this.title,
      @JsonKey(name: 'last_message') required this.lastMessage,
      @JsonKey(name: 'unread_count') this.unreadCount = 0,
      @JsonKey(name: 'other_user') required this.otherUser,
      @JsonKey(name: 'updated_at') required this.updatedAt})
      : super._();
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
  final LastMessageModel lastMessage;
  @override
  @JsonKey(name: 'unread_count')
  final int unreadCount;
  @override
  @JsonKey(name: 'other_user')
  final ChatUserModel otherUser;
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
      @JsonKey(name: 'last_message') LastMessageModel lastMessage,
      @JsonKey(name: 'unread_count') int unreadCount,
      @JsonKey(name: 'other_user') ChatUserModel otherUser,
      @JsonKey(name: 'updated_at') DateTime updatedAt});

  @override
  $LastMessageModelCopyWith<$Res> get lastMessage;
  @override
  $ChatUserModelCopyWith<$Res> get otherUser;
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
              as LastMessageModel,
      unreadCount: null == unreadCount
          ? _self.unreadCount
          : unreadCount // ignore: cast_nullable_to_non_nullable
              as int,
      otherUser: null == otherUser
          ? _self.otherUser
          : otherUser // ignore: cast_nullable_to_non_nullable
              as ChatUserModel,
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
  $LastMessageModelCopyWith<$Res> get lastMessage {
    return $LastMessageModelCopyWith<$Res>(_self.lastMessage, (value) {
      return _then(_self.copyWith(lastMessage: value));
    });
  }

  /// Create a copy of DirectChatModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ChatUserModelCopyWith<$Res> get otherUser {
    return $ChatUserModelCopyWith<$Res>(_self.otherUser, (value) {
      return _then(_self.copyWith(otherUser: value));
    });
  }
}

// dart format on
