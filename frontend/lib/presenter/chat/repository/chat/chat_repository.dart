import 'package:dio/dio.dart';
import 'package:fakegram/data/datasource/chat/chat_datasource.dart';
import 'package:fakegram/data/dto_s/chat/chat_response/chat_response_dto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_repository.g.dart';

@riverpod
ChatRepository chatRepository(Ref ref) {
  final dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ));

  dio.interceptors.add(LogInterceptor(
    requestBody: true,
    responseBody: true,
    logPrint: (log) => debugPrint('Dio: $log'),
  ));

  final chatDatasource = ChatDatasource(dio);
  return ChatRepository(chatDatasource);
}

class ChatRepository {
  final ChatDatasource _chatDatasource;

  ChatRepository(this._chatDatasource);

  Future<ChatResponseDTO> getChats(String token) async {
    try {
      return await _chatDatasource.chats(
        'application/json',
        'Bearer $token',
      );
    } on DioException catch(error) {
      debugPrint('ChatRepositoryERROR: $error');
      rethrow;
    }
  }
  
}