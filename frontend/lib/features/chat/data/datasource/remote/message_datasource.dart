import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/data/models/request/message_request_dto.dart';
import 'package:fakegram/features/chat/data/models/response/message_delete_response_dto.dart';
import 'package:fakegram/features/chat/data/models/response/send_message_response_dto.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/response/message_response_dto.dart';

part 'message_datasource.g.dart';

@RestApi()
abstract class MessageRemoteDatasource {
  factory MessageRemoteDatasource(Dio dio, {String baseUrl}) = _MessageRemoteDatasource;

  @GET('/messages/private-chat/{user_id}')
  Future<MessageResponseDTO> getMessages(
    @Path('user_id') String userId,
    @Query('direction') String direction,
    @Query('cursor') String? cursor,
    @Query('limit') int limit,
    @Header("accept") String accept,
    @Header("Authorization") String authorization,
  );

  @POST('/messages/send')
  Future<SendMessageResponseDTO> sendMessage(
    @Header("accept") String accept,
    @Header("Authorization") String authorization,
    @Body() Map<String, dynamic> request,
  );
  
  @DELETE('/messages/{message_id}')
  Future<MessageDeleteResponseDTO> deleteMessage(
    @Path('message_id') String messageId,
    @Header("accept") String accept,
    @Header("Authorization") String authorization,
  );
}