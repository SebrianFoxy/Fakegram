import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/entities/message_read_info_entity.dart';

part 'message_read_info_model.freezed.dart';
part 'message_read_info_model.g.dart';

@freezed
abstract class MessageReadInfoModel with _$MessageReadInfoModel {
  const factory MessageReadInfoModel({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'name') @Default('') String name,
    @JsonKey(name: 'surname') @Default('') String surname,
    @JsonKey(name: 'nickname') @Default('') String nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'read_at') required DateTime readAt,
  }) = _MessageReadInfoModel;

  const MessageReadInfoModel._();

  factory MessageReadInfoModel.fromJson(Map<String, dynamic> json) =>
      _$MessageReadInfoModelFromJson(json);

  MessageReadInfoEntity toEntity() => MessageReadInfoEntity(
    userId: userId,
    name: name,
    surname: surname,
    nickname: nickname,
    avatarUrl: avatarUrl,
    readAt: readAt,
  );
}