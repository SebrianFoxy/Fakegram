abstract class TokenService {
  Future<String?> getAccessToken();
  Future<void> deleteTokens();
  Future<void> updateToken();
}
