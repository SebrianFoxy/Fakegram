import 'package:freezed_annotation/freezed_annotation.dart';

part 'direct_message_model.freezed.dart';
part 'direct_message_model.g.dart';

@freezed
abstract class DirectMessageModel with _$DirectMessageModel {
  const factory DirectMessageModel({
    required String id,
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime createdAt,
    @Default(false) bool isRead,
    @Default(false) bool isDelivered,
  }) = _DirectMessageModel;

  factory DirectMessageModel.fromJson(Map<String, dynamic> json) => _$DirectMessageModelFromJson(json);
}