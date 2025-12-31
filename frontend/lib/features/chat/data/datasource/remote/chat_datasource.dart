import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../models/response/chat_response_dto.dart';

part 'chat_datasource.g.dart';

@RestApi()
abstract class ChatRemoteDatasource {
  factory ChatRemoteDatasource(Dio dio, {String baseUrl}) = _ChatRemoteDatasource;

  @GET('/chats')
  Future<ChatResponseDTO> chats(
      @Header("accept") String accept,
      @Header("Authorization") String authorization,);
}