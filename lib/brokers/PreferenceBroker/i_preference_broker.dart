abstract class IPreferenceBroker {
  Future<void> setTokenAsync(String token);
  Future<void> clearTokenAsync();
  Future<String?> getTokenAsync();
}