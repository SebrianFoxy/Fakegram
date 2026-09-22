import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_read_info_entity.freezed.dart';
part 'message_read_info_entity.g.dart';

@freezed
abstract class MessageReadInfoEntity with _$MessageReadInfoEntity {
  const factory MessageReadInfoEntity({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'surname') @Default('') String surname,
    @JsonKey(name: 'nickname') @Default('') String nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'read_at') required DateTime readAt,
  }) = _MessageReadInfoEntity;

  factory MessageReadInfoEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageReadInfoEntityFromJson(json);
}