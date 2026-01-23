import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';

import '../../../../core/network/error_handling/error_handler.dart';
import '../../../auth/domain/services/token_service.dart';
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
  Future<List<MessageEntity>> getMessages({
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

      return response.messages.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }
}