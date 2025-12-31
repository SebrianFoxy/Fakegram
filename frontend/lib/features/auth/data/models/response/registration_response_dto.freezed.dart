// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'registration_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RegistrationResponseDTO {
  @JsonKey(name: "error")
  String? get error;

  /// Create a copy of RegistrationResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RegistrationResponseDTOCopyWith<RegistrationResponseDTO> get copyWith =>
      _$RegistrationResponseDTOCopyWithImpl<RegistrationResponseDTO>(
          this as RegistrationResponseDTO, _$identity);

  /// Serializes this RegistrationResponseDTO to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is RegistrationResponseDTO &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'RegistrationResponseDTO(error: $error)';
  }
}

/// @nodoc
abstract mixin class $RegistrationResponseDTOCopyWith<$Res> {
  factory $RegistrationResponseDTOCopyWith(RegistrationResponseDTO value,
          $Res Function(RegistrationResponseDTO) _then) =
      _$RegistrationResponseDTOCopyWithImpl;
  @useResult
  $Res call({@JsonKey(name: "error") String? error});
}

/// @nodoc
class _$RegistrationResponseDTOCopyWithImpl<$Res>
    implements $RegistrationResponseDTOCopyWith<$Res> {
  _$RegistrationResponseDTOCopyWithImpl(this._self, this._then);

  final RegistrationResponseDTO _self;
  final $Res Function(RegistrationResponseDTO) _then;

  /// Create a copy of RegistrationResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_self.copyWith(
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _RegistrationResponseDTO implements RegistrationResponseDTO {
  const _RegistrationResponseDTO({@JsonKey(name: "error") this.error});
  factory _RegistrationResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$RegistrationResponseDTOFromJson(json);

  @override
  @JsonKey(name: "error")
  final String? error;

  /// Create a copy of RegistrationResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RegistrationResponseDTOCopyWith<_RegistrationResponseDTO> get copyWith =>
      __$RegistrationResponseDTOCopyWithImpl<_RegistrationResponseDTO>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RegistrationResponseDTOToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _RegistrationResponseDTO &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error);

  @override
  String toString() {
    return 'RegistrationResponseDTO(error: $error)';
  }
}

/// @nodoc
abstract mixin class _$RegistrationResponseDTOCopyWith<$Res>
    implements $RegistrationResponseDTOCopyWith<$Res> {
  factory _$RegistrationResponseDTOCopyWith(_RegistrationResponseDTO value,
          $Res Function(_RegistrationResponseDTO) _then) =
      __$RegistrationResponseDTOCopyWithImpl;
  @override
  @useResult
  $Res call({@JsonKey(name: "error") String? error});
}

/// @nodoc
class __$RegistrationResponseDTOCopyWithImpl<$Res>
    implements _$RegistrationResponseDTOCopyWith<$Res> {
  __$RegistrationResponseDTOCopyWithImpl(this._self, this._then);

  final _RegistrationResponseDTO _self;
  final $Res Function(_RegistrationResponseDTO) _then;

  /// Create a copy of RegistrationResponseDTO
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? error = freezed,
  }) {
    return _then(_RegistrationResponseDTO(
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
