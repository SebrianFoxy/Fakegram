import 'package:fakegram/features/auth/domain/entities/token_entity.dart';
import 'package:fakegram/features/auth/domain/entities/user_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_result_entity.freezed.dart';

@freezed
abstract class AuthResultEntity with _$AuthResultEntity{
  const AuthResultEntity._();

  const factory AuthResultEntity({
    required UserEntity user,
    required TokenEntity token,
  }) = _AuthResultEntity;
}