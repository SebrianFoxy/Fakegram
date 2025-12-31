import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/direct_message_entity.dart';

part 'direct_message_model.freezed.dart';
part 'direct_message_model.g.dart';

@freezed
abstract class DirectMessageModel with _$DirectMessageModel {
  const DirectMessageModel._();

  const factory DirectMessageModel({
    required String id,
    required String senderId,
    required String receiverId,
    required String text,
    required DateTime createdAt,
    @Default(false) bool isRead,
    @Default(false) bool isDelivered,
    @Default(false) bool isDeleted,
  }) = _DirectMessageModel;

  factory DirectMessageModel.fromJson(Map<String, dynamic> json) =>
      _$DirectMessageModelFromJson(json);

  DirectMessageEntity toEntity() => DirectMessageEntity(
    id: id,
    senderId: senderId,
    receiverId: receiverId,
    text: text,
    createdAt: createdAt,
    isRead: isRead,
    isDelivered: isDelivered,
    isDeleted: isDeleted,
  );
}