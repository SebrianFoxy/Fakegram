import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDTO with _$UserDTO {
  const UserDTO._();

  const factory UserDTO({
    required String id,
    required String email,
    required String name,
    required String surname,
    required String nickname,
    @Default(false) bool approved,
  }) = _UserDTO;

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      name: name,
      surname: surname,
      nickname: nickname,
      approved: approved,
    );
  }
}