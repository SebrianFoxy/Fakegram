import 'package:dio/dio.dart';
import 'package:fakegram/data/dto_s/chat/chat_response/chat_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_datasource.g.dart';

@RestApi(baseUrl: 'http://127.0.0.1:8080/api/v1')
abstract class ChatDatasource {
  factory ChatDatasource(Dio dio) = _ChatDatasource;

  @GET('/chats')
  Future<ChatResponseDTO> chats(
      @Header("accept") String accept,
      @Header("Authorization") String authorization,
      );
}