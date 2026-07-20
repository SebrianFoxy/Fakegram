import 'package:dio/dio.dart';
import 'package:fakegram/features/auth/domain/services/token_service.dart';
import 'package:fakegram/features/chat/data/datasource/remote/chat_datasource.dart';
import 'package:fakegram/features/chat/domain/entities/direct_chat_entity.dart';
import 'package:fakegram/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/network/error_handling/error_handler.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDatasource _remoteDataSource;
  final TokenService _tokenService;

  ChatRepositoryImpl({
    required ChatRemoteDatasource remoteDataSource,
    required TokenService tokenService,
  })  : _remoteDataSource = remoteDataSource,
        _tokenService = tokenService;

  @override
  Future<List<DirectChatEntity>> getChats() async {
    try {
      final accessToken = getAccessToken();

      final response = await _remoteDataSource.getChats(
        'application/json',
        'Bearer $accessToken',
      );

      return response.chats.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  @override
  Future<List<DirectChatEntity>> searchChats({
    required String query,
    required int offset,
    required int limit
  }) async {
    try {
      final accessToken = getAccessToken();

      final response = await _remoteDataSource.findChats(
        query,
        offset,
        limit,
        'application/json',
        'Bearer $accessToken',
      );

      return response.chats.map((model) => model.toEntity()).toList();
    } on DioException catch (error) {
      throw ErrorHandler.handleDioError(error);
    } catch (error) {
      throw ErrorHandler.handleError(error);
    }
  }

  Future<String?> getAccessToken() async {
    try {
      final accessToken = await _tokenService.getAccessToken();

      if (accessToken == null || accessToken.isEmpty) {
        throw Exception('Access token is missing');
      }

      return accessToken;
    } catch (e) {
      debugPrint('getAccessTokenMessageRepositoryError: $e');
      return null;
    }
  }
}