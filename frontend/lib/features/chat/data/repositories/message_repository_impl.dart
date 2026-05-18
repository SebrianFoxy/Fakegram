import 'package:dio/dio.dart';
import 'package:fakegram/features/chat/data/models/request/message_request_dto.dart';
import 'package:fakegram/features/chat/domain/entities/message_entity.dart';
import 'package:flutter/material.dart';
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
  })  : _remoteDataSource = remoteDataSource,
        _tokenService = tokenService;

  @override
  Future<PaginationMessagesEntity> getInitialMessages({
    required String userId,
    String? cursor,
    required int limit,
  }) async {
    return _getMessages(
      userId: userId,
      direction: 'around',
      cursor: cursor,
      limit: limit,
    );
  }

  @override
  Future<PaginationMessagesEntity> getOlderMessages({
    required String userId,
    required String cursor,
    required int limit,
  }) async {
    return _getMessages(
      userId: userId,
      direction: 'older',
      cursor: cursor,
      limit: limit,
    );
  }

  @override
  Future<PaginationMessagesEntity> getNewerMessages({
    required String userId,
    required String cursor,
    required int limit,
  }) async {
    return _getMessages(
      userId: userId,
      direction: 'newer',
      cursor: cursor,
      limit: limit,
    );
  }

  Future<PaginationMessagesEntity> _getMessages({
    required String userId,
    required String direction,
    String? cursor,
    required int limit,
  }) async {
    try {
      final accessToken = await _tokenService.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token is missing');
      }

      final response = await _remoteDataSource.getMessages(
        userId,
        direction,
        cursor,
        limit,
        'application/json',
        'Bearer $accessToken',
      );

      return PaginationMessagesEntity(
        messages: response.messages.map((model) => model.toEntity()).toList(),
        count: response.count,
        totalUnread: response.totalUnread,
        hasMoreOlder: response.hasMoreOlder,
        hasMoreNewer: response.hasMoreNewer,
        firstMsgTime: response.firstMsgTime != null
            ? DateTime.parse(response.firstMsgTime!)
            : null,
        lastMsgTime: response.lastMsgTime != null
            ? DateTime.parse(response.lastMsgTime!)
            : null,
        olderCursor: response.cursors?.older,
        newerCursor: response.cursors?.newer,
      );
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      debugPrint('GetMessagesError: $error');
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
        replyToMessageId: replyToMessageId,
      ).toJson();

      final response = await _remoteDataSource.sendMessage(
        'application/json',
        'Bearer $accessToken',
        request,
      );

      return response.message.toEntity();
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  @override
  Future<void> deleteMessage({
    required String messageId
  }) async {
    try {
      final accessToken = await _tokenService.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token is missing');
      }

      await _remoteDataSource.deleteMessage(
        messageId,
        'application/json',
        'Bearer $accessToken',
      );
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }
}