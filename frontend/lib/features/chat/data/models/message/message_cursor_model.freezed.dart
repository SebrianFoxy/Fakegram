// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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
