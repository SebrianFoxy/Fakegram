// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_cursor_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageCursorsModel {
  @JsonKey(name: 'older')
  String? get older;
  @JsonKey(name: 'newer')
  String? get newer;

  /// Create a copy of MessageCursorsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MessageCursorsModelCopyWith<MessageCursorsModel> get copyWith =>
      _$MessageCursorsModelCopyWithImpl<MessageCursorsModel>(
          this as MessageCursorsModel, _$identity);

  /// Serializes this MessageCursorsModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MessageCursorsModel &&
            (identical(other.older, older) || other.older == older) &&
            (identical(other.newer, newer) || other.newer == newer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, older, newer);

  @override
  String toString() {
    return 'MessageCursorsModel(older: $older, newer: $newer)';
  }
}

/// @nodoc
abstract mixin class $MessageCursorsModelCopyWith<$Res> {
  factory $MessageCursorsModelCopyWith(
          MessageCursorsModel value, $Res Function(MessageCursorsModel) _then) =
      _$MessageCursorsModelCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'older') String? older,
      @JsonKey(name: 'newer') String? newer});
}

/// @nodoc
class _$MessageCursorsModelCopyWithImpl<$Res>
    implements $MessageCursorsModelCopyWith<$Res> {
  _$MessageCursorsModelCopyWithImpl(this._self, this._then);

  final MessageCursorsModel _self;
  final $Res Function(MessageCursorsModel) _then;

  /// Create a copy of MessageCursorsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? older = freezed,
    Object? newer = freezed,
  }) {
    return _then(_self.copyWith(
      older: freezed == older
          ? _self.older
          : older // ignore: cast_nullable_to_non_nullable
              as String?,
      newer: freezed == newer
          ? _self.newer
          : newer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [MessageCursorsModel].
extension MessageCursorsModelPatterns on MessageCursorsModel {
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
    TResult Function(_MessageCursorsModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel() when $default != null:
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
    TResult Function(_MessageCursorsModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel():
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
    TResult? Function(_MessageCursorsModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel() when $default != null:
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
    TResult Function(@JsonKey(name: 'older') String? older,
            @JsonKey(name: 'newer') String? newer)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel() when $default != null:
        return $default(_that.older, _that.newer);
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
    TResult Function(@JsonKey(name: 'older') String? older,
            @JsonKey(name: 'newer') String? newer)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel():
        return $default(_that.older, _that.newer);
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
    TResult? Function(@JsonKey(name: 'older') String? older,
            @JsonKey(name: 'newer') String? newer)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MessageCursorsModel() when $default != null:
        return $default(_that.older, _that.newer);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _MessageCursorsModel implements MessageCursorsModel {
  const _MessageCursorsModel(
      {@JsonKey(name: 'older') this.older, @JsonKey(name: 'newer') this.newer});
  factory _MessageCursorsModel.fromJson(Map<String, dynamic> json) =>
      _$MessageCursorsModelFromJson(json);

  @override
  @JsonKey(name: 'older')
  final String? older;
  @override
  @JsonKey(name: 'newer')
  final String? newer;

  /// Create a copy of MessageCursorsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MessageCursorsModelCopyWith<_MessageCursorsModel> get copyWith =>
      __$MessageCursorsModelCopyWithImpl<_MessageCursorsModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$MessageCursorsModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MessageCursorsModel &&
            (identical(other.older, older) || other.older == older) &&
            (identical(other.newer, newer) || other.newer == newer));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, older, newer);

  @override
  String toString() {
    return 'MessageCursorsModel(older: $older, newer: $newer)';
  }
}

/// @nodoc
abstract mixin class _$MessageCursorsModelCopyWith<$Res>
    implements $MessageCursorsModelCopyWith<$Res> {
  factory _$MessageCursorsModelCopyWith(_MessageCursorsModel value,
          $Res Function(_MessageCursorsModel) _then) =
      __$MessageCursorsModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'older') String? older,
      @JsonKey(name: 'newer') String? newer});
}

/// @nodoc
class __$MessageCursorsModelCopyWithImpl<$Res>
    implements _$MessageCursorsModelCopyWith<$Res> {
  __$MessageCursorsModelCopyWithImpl(this._self, this._then);

  final _MessageCursorsModel _self;
  final $Res Function(_MessageCursorsModel) _then;

  /// Create a copy of MessageCursorsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? older = freezed,
    Object? newer = freezed,
  }) {
    return _then(_MessageCursorsModel(
      older: freezed == older
          ? _self.older
          : older // ignore: cast_nullable_to_non_nullable
              as String?,
      newer: freezed == newer
          ? _self.newer
          : newer // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
