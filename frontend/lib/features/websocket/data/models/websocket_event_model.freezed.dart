// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_event_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WebSocketEventModel {
  String get type;
  Map<String, dynamic> get payload;

  /// Create a copy of WebSocketEventModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $WebSocketEventModelCopyWith<WebSocketEventModel> get copyWith =>
      _$WebSocketEventModelCopyWithImpl<WebSocketEventModel>(
          this as WebSocketEventModel, _$identity);

  /// Serializes this WebSocketEventModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebSocketEventModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.payload, payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(payload));

  @override
  String toString() {
    return 'WebSocketEventModel(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class $WebSocketEventModelCopyWith<$Res> {
  factory $WebSocketEventModelCopyWith(
          WebSocketEventModel value, $Res Function(WebSocketEventModel) _then) =
      _$WebSocketEventModelCopyWithImpl;
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class _$WebSocketEventModelCopyWithImpl<$Res>
    implements $WebSocketEventModelCopyWith<$Res> {
  _$WebSocketEventModelCopyWithImpl(this._self, this._then);

  final WebSocketEventModel _self;
  final $Res Function(WebSocketEventModel) _then;

  /// Create a copy of WebSocketEventModel
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
class _WebSocketEventModel extends WebSocketEventModel {
  const _WebSocketEventModel(
      {required this.type, required final Map<String, dynamic> payload})
      : _payload = payload,
        super._();
  factory _WebSocketEventModel.fromJson(Map<String, dynamic> json) =>
      _$WebSocketEventModelFromJson(json);

  @override
  final String type;
  final Map<String, dynamic> _payload;
  @override
  Map<String, dynamic> get payload {
    if (_payload is EqualUnmodifiableMapView) return _payload;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_payload);
  }

  /// Create a copy of WebSocketEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$WebSocketEventModelCopyWith<_WebSocketEventModel> get copyWith =>
      __$WebSocketEventModelCopyWithImpl<_WebSocketEventModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$WebSocketEventModelToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _WebSocketEventModel &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._payload, _payload));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, const DeepCollectionEquality().hash(_payload));

  @override
  String toString() {
    return 'WebSocketEventModel(type: $type, payload: $payload)';
  }
}

/// @nodoc
abstract mixin class _$WebSocketEventModelCopyWith<$Res>
    implements $WebSocketEventModelCopyWith<$Res> {
  factory _$WebSocketEventModelCopyWith(_WebSocketEventModel value,
          $Res Function(_WebSocketEventModel) _then) =
      __$WebSocketEventModelCopyWithImpl;
  @override
  @useResult
  $Res call({String type, Map<String, dynamic> payload});
}

/// @nodoc
class __$WebSocketEventModelCopyWithImpl<$Res>
    implements _$WebSocketEventModelCopyWith<$Res> {
  __$WebSocketEventModelCopyWithImpl(this._self, this._then);

  final _WebSocketEventModel _self;
  final $Res Function(_WebSocketEventModel) _then;

  /// Create a copy of WebSocketEventModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? type = null,
    Object? payload = null,
  }) {
    return _then(_WebSocketEventModel(
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
