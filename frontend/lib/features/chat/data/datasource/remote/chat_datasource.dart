import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/data/models/response/search_chat_response_dto.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/response/chat_response_dto.dart';

part 'chat_datasource.g.dart';

@RestApi()
abstract class ChatRemoteDatasource {
  factory ChatRemoteDatasource(Dio dio, {String baseUrl}) = _ChatRemoteDatasource;

  @GET('/chats')
  Future<ChatResponseDTO> getChats(
      @Header("accept") String accept,
      @Header("Authorization") String authorization,
  );

  @GET('/chats/search')
  Future<SearchChatResponseDTO> findChats(
      @Query('query') String query,
      @Query('offset') int offset,
      @Query('limit') int limit,
      @Header("accept") String accept,
      @Header("Authorization") String authorization,
  );
}