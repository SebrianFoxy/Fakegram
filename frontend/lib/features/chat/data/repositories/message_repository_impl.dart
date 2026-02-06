import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/data/models/request/message_request_dto.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import '../../../../core/network/error_handling/error_handler.dart';
import '../../../auth/domain/services/token_service.dart';
import '../../domain/entities/pagination_messages_entity.dart';
import '../../domain/repositories/message_repository.dart';
import '../datasource/remote/message_datasource.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageRemoteDatasource _remoteDataSource;
  final TokenService _tokenService;

  MessageRepositoryImpl({
    required MessageRemoteDatasource remoteDataSource,
    required TokenService tokenService,
  })
      : _remoteDataSource = remoteDataSource,
        _tokenService = tokenService;

  @override
  Future<PaginationMessagesEntity> getMessages({
    required String userId,
    required int page,
    required int limit,
  }) async {
    try {
      final accessToken = await _tokenService.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token is missing');
      }

      final response = await _remoteDataSource.messages(
        userId,
        page,
        limit,
        'application/json',
        'Bearer $accessToken',
      );

      final messagesList = response.messages ?? [];

      return PaginationMessagesEntity(
        messages: messagesList.map((model) => model.toEntity()).toList(),
        page: response.page ?? page,
        count: response.count ?? 0,
        limit: response.limit ?? limit,
        total: response.total ?? 0,
        hasNext: response.hasNext ?? false,
        hasPrev: response.hasPrev ?? false,
      );
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  @override
  Future<MessageEntity> sendMessage({
    required String chatId,
    required String messageText,
    required String messageType,
    required String replyToMessageId,
  }) async {
    try {
      final accessToken = await _tokenService.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token is missing');
      }

      final request = MessageRequestDTO(
          chatId: chatId,
          message: messageText,
          messageType: messageType,
          replyToMessageId: replyToMessageId
      ).toJson();

      final response = await _remoteDataSource.sendMessage(
          'application/json',
          'Bearer $accessToken',
          request
      );

      return response.message.toEntity();
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }
}