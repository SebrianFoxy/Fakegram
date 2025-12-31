import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
abstract class UserEntity with _$UserEntity {
  const UserEntity._();

  const factory UserEntity({
    required String id,
    required String email,
    required String name,
    required String surname,
    required String nickname,
    @Default(false) bool approved,
  }) = _UserEntity;

  String get fullName => '$name $surname';
  String get displayName => nickname.isNotEmpty ? nickname : fullName;
}
