import 'package:hello_world/brokers/PreferenceBroker/i_preference_broker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceBroker implements IPreferenceBroker {
  @override
  Future<void> setTokenAsync(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bearer_token', token);
  }

  @override
  Future<void> clearTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('bearer_token');
  }

  @override
  Future<String?> getTokenAsync() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('bearer_token');
  }
}