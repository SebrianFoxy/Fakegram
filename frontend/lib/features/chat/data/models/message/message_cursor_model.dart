import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_cursor_model.freezed.dart';
part 'message_cursor_model.g.dart';

@freezed
abstract class MessageCursorsModel with _$MessageCursorsModel {
  const factory MessageCursorsModel({
    @JsonKey(name: 'older') String? older,
    @JsonKey(name: 'newer') String? newer,
  }) = _MessageCursorsModel;

  factory MessageCursorsModel.fromJson(Map<String, dynamic> json) =>
      _$MessageCursorsModelFromJson(json);
}