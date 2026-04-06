// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageDetailModel {
  String get id;
  @JsonKey(name: 'chat_id')
  String get chatId;
  @JsonKey(name: 'sender_id')
  String get senderId;
  @JsonKey(name: 'message_text')
  String get messageText;
  @JsonKey(name: 'message_type')
  String get messageType;
  @JsonKey(name: 'reply_to_message_id', defaultValue: null)
  String? get replyToMessageId;
  @JsonKey(name: 'is_edited', defaultValue: false)
  bool get isEdited;
  @JsonKey(name: 'is_deleted', defaultValue: false)
  bool get isDeleted;
  @JsonKey(name: 'is_read', defaultValue: false)
  bool get isRead;
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @JsonKey(name: 'read_at')
  DateTime? get readAt;
  @JsonKey(name: 'sender')
  MessageUserDetailModel get sender;
  @JsonKey(name: 'reply_to_message', defaultValue: null)
  MessageDetailModel? get replyToMessage;

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<MessageDetailModel> get copyWith =>
      _$MessageDetailModelCopyWithImpl<MessageDetailModel>(
          this as MessageDetailModel, _$identity);

  /// Serializes this MessageDetailModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageDetailModel &&
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
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      isRead,
      createdAt,
      readAt,
      sender,
      replyToMessage);

  @override
  String toString() {
    return 'MessageDetailModel(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, isEdited: $isEdited, isDeleted: $isDeleted, isRead: $isRead, createdAt: $createdAt, readAt: $readAt, sender: $sender, replyToMessage: $replyToMessage)';
  }
}

/// @nodoc
abstract mixin class $MessageDetailModelCopyWith<$Res> {
  factory $MessageDetailModelCopyWith(
          MessageDetailModel value, $Res Function(MessageDetailModel) _then) =
      _$MessageDetailModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'message_text') String messageText,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'reply_to_message_id', defaultValue: null)
      String? replyToMessageId,
      @JsonKey(name: 'is_edited', defaultValue: false) bool isEdited,
      @JsonKey(name: 'is_deleted', defaultValue: false) bool isDeleted,
      @JsonKey(name: 'is_read', defaultValue: false) bool isRead,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'read_at') DateTime? readAt,
      @JsonKey(name: 'sender') MessageUserDetailModel sender,
      @JsonKey(name: 'reply_to_message', defaultValue: null)
      MessageDetailModel? replyToMessage});

  $MessageUserDetailModelCopyWith<$Res> get sender;
  $MessageDetailModelCopyWith<$Res>? get replyToMessage;
}

/// @nodoc
class _$MessageDetailModelCopyWithImpl<$Res>
    implements $MessageDetailModelCopyWith<$Res> {
  _$MessageDetailModelCopyWithImpl(this._self, this._then);

  final MessageDetailModel _self;
  final $Res Function(MessageDetailModel) _then;

  /// Create a copy of MessageDetailModel
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
    Object? isRead = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? sender = null,
    Object? replyToMessage = freezed,
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
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as MessageUserDetailModel,
      replyToMessage: freezed == replyToMessage
          ? _self.replyToMessage
          : replyToMessage // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel?,
    ));
  }

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageUserDetailModelCopyWith<$Res> get sender {
    return $MessageUserDetailModelCopyWith<$Res>(_self.sender, (value) {
      return _then(_self.copyWith(sender: value));
    });
  }

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
      return null;
    }

    return $MessageDetailModelCopyWith<$Res>(_self.replyToMessage!, (value) {
      return _then(_self.copyWith(replyToMessage: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MessageDetailModel].
extension MessageDetailModelPatterns on MessageDetailModel {
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
    TResult Function(_MessageDetailModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel() when $default != null:
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
    TResult Function(_MessageDetailModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel():
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
    TResult? Function(_MessageDetailModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel() when $default != null:
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
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'sender_id') String senderId,
            @JsonKey(name: 'message_text') String messageText,
            @JsonKey(name: 'message_type') String messageType,
            @JsonKey(name: 'reply_to_message_id', defaultValue: null)
            String? replyToMessageId,
            @JsonKey(name: 'is_edited', defaultValue: false) bool isEdited,
            @JsonKey(name: 'is_deleted', defaultValue: false) bool isDeleted,
            @JsonKey(name: 'is_read', defaultValue: false) bool isRead,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'read_at') DateTime? readAt,
            @JsonKey(name: 'sender') MessageUserDetailModel sender,
            @JsonKey(name: 'reply_to_message', defaultValue: null)
            MessageDetailModel? replyToMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel() when $default != null:
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.sender,
            _that.replyToMessage);
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
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'sender_id') String senderId,
            @JsonKey(name: 'message_text') String messageText,
            @JsonKey(name: 'message_type') String messageType,
            @JsonKey(name: 'reply_to_message_id', defaultValue: null)
            String? replyToMessageId,
            @JsonKey(name: 'is_edited', defaultValue: false) bool isEdited,
            @JsonKey(name: 'is_deleted', defaultValue: false) bool isDeleted,
            @JsonKey(name: 'is_read', defaultValue: false) bool isRead,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'read_at') DateTime? readAt,
            @JsonKey(name: 'sender') MessageUserDetailModel sender,
            @JsonKey(name: 'reply_to_message', defaultValue: null)
            MessageDetailModel? replyToMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel():
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.sender,
            _that.replyToMessage);
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
            @JsonKey(name: 'chat_id') String chatId,
            @JsonKey(name: 'sender_id') String senderId,
            @JsonKey(name: 'message_text') String messageText,
            @JsonKey(name: 'message_type') String messageType,
            @JsonKey(name: 'reply_to_message_id', defaultValue: null)
            String? replyToMessageId,
            @JsonKey(name: 'is_edited', defaultValue: false) bool isEdited,
            @JsonKey(name: 'is_deleted', defaultValue: false) bool isDeleted,
            @JsonKey(name: 'is_read', defaultValue: false) bool isRead,
            @JsonKey(name: 'created_at') DateTime createdAt,
            @JsonKey(name: 'read_at') DateTime? readAt,
            @JsonKey(name: 'sender') MessageUserDetailModel sender,
            @JsonKey(name: 'reply_to_message', defaultValue: null)
            MessageDetailModel? replyToMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageDetailModel() when $default != null:
        return $default(
            _that.id,
            _that.chatId,
            _that.senderId,
            _that.messageText,
            _that.messageType,
            _that.replyToMessageId,
            _that.isEdited,
            _that.isDeleted,
            _that.isRead,
            _that.createdAt,
            _that.readAt,
            _that.sender,
            _that.replyToMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageDetailModel extends MessageDetailModel {
  const _MessageDetailModel(
      {required this.id,
      @JsonKey(name: 'chat_id') required this.chatId,
      @JsonKey(name: 'sender_id') required this.senderId,
      @JsonKey(name: 'message_text') required this.messageText,
      @JsonKey(name: 'message_type') required this.messageType,
      @JsonKey(name: 'reply_to_message_id', defaultValue: null)
      this.replyToMessageId,
      @JsonKey(name: 'is_edited', defaultValue: false) required this.isEdited,
      @JsonKey(name: 'is_deleted', defaultValue: false) required this.isDeleted,
      @JsonKey(name: 'is_read', defaultValue: false) required this.isRead,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'read_at') required this.readAt,
      @JsonKey(name: 'sender') required this.sender,
      @JsonKey(name: 'reply_to_message', defaultValue: null)
      this.replyToMessage})
      : super._();
  factory _MessageDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailModelFromJson(json);

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
  @JsonKey(name: 'reply_to_message_id', defaultValue: null)
  final String? replyToMessageId;
  @override
  @JsonKey(name: 'is_edited', defaultValue: false)
  final bool isEdited;
  @override
  @JsonKey(name: 'is_deleted', defaultValue: false)
  final bool isDeleted;
  @override
  @JsonKey(name: 'is_read', defaultValue: false)
  final bool isRead;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'read_at')
  final DateTime? readAt;
  @override
  @JsonKey(name: 'sender')
  final MessageUserDetailModel sender;
  @override
  @JsonKey(name: 'reply_to_message', defaultValue: null)
  final MessageDetailModel? replyToMessage;

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageDetailModelCopyWith<_MessageDetailModel> get copyWith =>
      __$MessageDetailModelCopyWithImpl<_MessageDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageDetailModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageDetailModel &&
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
            (identical(other.isRead, isRead) || other.isRead == isRead) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.replyToMessage, replyToMessage) ||
                other.replyToMessage == replyToMessage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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
      isRead,
      createdAt,
      readAt,
      sender,
      replyToMessage);

  @override
  String toString() {
    return 'MessageDetailModel(id: $id, chatId: $chatId, senderId: $senderId, messageText: $messageText, messageType: $messageType, replyToMessageId: $replyToMessageId, isEdited: $isEdited, isDeleted: $isDeleted, isRead: $isRead, createdAt: $createdAt, readAt: $readAt, sender: $sender, replyToMessage: $replyToMessage)';
  }
}

/// @nodoc
abstract mixin class _$MessageDetailModelCopyWith<$Res>
    implements $MessageDetailModelCopyWith<$Res> {
  factory _$MessageDetailModelCopyWith(
          _MessageDetailModel value, $Res Function(_MessageDetailModel) _then) =
      __$MessageDetailModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: 'chat_id') String chatId,
      @JsonKey(name: 'sender_id') String senderId,
      @JsonKey(name: 'message_text') String messageText,
      @JsonKey(name: 'message_type') String messageType,
      @JsonKey(name: 'reply_to_message_id', defaultValue: null)
      String? replyToMessageId,
      @JsonKey(name: 'is_edited', defaultValue: false) bool isEdited,
      @JsonKey(name: 'is_deleted', defaultValue: false) bool isDeleted,
      @JsonKey(name: 'is_read', defaultValue: false) bool isRead,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'read_at') DateTime? readAt,
      @JsonKey(name: 'sender') MessageUserDetailModel sender,
      @JsonKey(name: 'reply_to_message', defaultValue: null)
      MessageDetailModel? replyToMessage});

  @override
  $MessageUserDetailModelCopyWith<$Res> get sender;
  @override
  $MessageDetailModelCopyWith<$Res>? get replyToMessage;
}

/// @nodoc
class __$MessageDetailModelCopyWithImpl<$Res>
    implements _$MessageDetailModelCopyWith<$Res> {
  __$MessageDetailModelCopyWithImpl(this._self, this._then);

  final _MessageDetailModel _self;
  final $Res Function(_MessageDetailModel) _then;

  /// Create a copy of MessageDetailModel
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
    Object? isRead = null,
    Object? createdAt = null,
    Object? readAt = freezed,
    Object? sender = null,
    Object? replyToMessage = freezed,
  }) {
    return _then(_MessageDetailModel(
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
      isRead: null == isRead
          ? _self.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      readAt: freezed == readAt
          ? _self.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      sender: null == sender
          ? _self.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as MessageUserDetailModel,
      replyToMessage: freezed == replyToMessage
          ? _self.replyToMessage
          : replyToMessage // ignore: cast_nullable_to_non_nullable
              as MessageDetailModel?,
    ));
  }

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageUserDetailModelCopyWith<$Res> get sender {
    return $MessageUserDetailModelCopyWith<$Res>(_self.sender, (value) {
      return _then(_self.copyWith(sender: value));
    });
  }

  /// Create a copy of MessageDetailModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MessageDetailModelCopyWith<$Res>? get replyToMessage {
    if (_self.replyToMessage == null) {
      return null;
    }

    return $MessageDetailModelCopyWith<$Res>(_self.replyToMessage!, (value) {
      return _then(_self.copyWith(replyToMessage: value));
    });
  }
}

// dart format on
