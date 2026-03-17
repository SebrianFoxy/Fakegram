import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_user_detail_model.freezed.dart';
part 'message_user_detail_model.g.dart';

@freezed
abstract class MessageUserDetailModel with _$MessageUserDetailModel {
  const factory MessageUserDetailModel({
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'surname') required String surname,
    @JsonKey(name: 'nickname') required String nickname,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _MessageUserDetailModel;

  factory MessageUserDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MessageUserDetailModelFromJson(json);
}