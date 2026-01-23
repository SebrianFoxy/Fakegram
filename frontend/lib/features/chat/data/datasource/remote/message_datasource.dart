import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/response/message_response_dto.dart';

part 'message_datasource.g.dart';

@RestApi()
abstract class MessageRemoteDatasource {
  factory MessageRemoteDatasource(Dio dio, {String baseUrl}) = _MessageRemoteDatasource;

  @GET('/messages/private-chat/{user_id}')
  Future<MessageResponseDTO> messages(
      @Path('user_id') String userId,
      @Query('page') int page,
      @Query('limit') int limit,
      @Header("accept") String accept,
      @Header("Authorization") String authorization,
  );
}