// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketMessageModel {
  String get type;
  Map<String, dynamic> get payload;

  /// Create a copy of WebSocketMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketMessageModelCopyWith<WebSocketMessageModel> get copyWith =>
      _$WebSocketMessageModelCopyWithImpl<WebSocketMessageModel>(
          this as WebSocketMessageModel, _$identity);

  /// Serializes this WebSocketMessageModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketMessageModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(payload));

  @override
  String toString() {
    return 'WebSocketMessageModel(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $WebSocketMessageModelCopyWith<$Res> {
  factory $WebSocketMessageModelCopyWith(WebSocketMessageModel value,
          $Res Function(WebSocketMessageModel) _then) =
      _$WebSocketMessageModelCopyWithImpl;
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class _$WebSocketMessageModelCopyWithImpl<$Res>
    implements $WebSocketMessageModelCopyWith<$Res> {
  _$WebSocketMessageModelCopyWithImpl(this._self, this._then);

  final WebSocketMessageModel _self;
  final $Res Function(WebSocketMessageModel) _then;

  /// Create a copy of WebSocketMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_self.copyWith(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _WebSocketMessageModel extends WebSocketMessageModel {
  const _WebSocketMessageModel(
      {required this.type, required final Map<String, dynamic> payload})
      : _payload = payload,
        super._();
  factory _WebSocketMessageModel.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageModelFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  /// Create a copy of WebSocketMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketMessageModelCopyWith<_WebSocketMessageModel> get copyWith =>
      __$WebSocketMessageModelCopyWithImpl<_WebSocketMessageModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketMessageModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketMessageModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_payload));

  @override
  String toString() {
    return 'WebSocketMessageModel(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketMessageModelCopyWith<$Res>
    implements $WebSocketMessageModelCopyWith<$Res> {
  factory _$WebSocketMessageModelCopyWith(_WebSocketMessageModel value,
          $Res Function(_WebSocketMessageModel) _then) =
      __$WebSocketMessageModelCopyWithImpl;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class __$WebSocketMessageModelCopyWithImpl<$Res>
    implements _$WebSocketMessageModelCopyWith<$Res> {
  __$WebSocketMessageModelCopyWithImpl(this._self, this._then);

  final _WebSocketMessageModel _self;
  final $Res Function(_WebSocketMessageModel) _then;

  /// Create a copy of WebSocketMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_WebSocketMessageModel(
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _self._payload
          : payload // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
