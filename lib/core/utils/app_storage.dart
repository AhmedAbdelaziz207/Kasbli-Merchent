import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const String _keyUserId = 'user_id';
  static const String _keyUserName = 'user_name';
  static const String _keyUserToken = 'user_token';
  static const String _keyIsLoggedIn = 'is_logged_in';

  static Future<void> saveUserData({
    required String id,
    required String name,
    required String token,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUserId, id);
    await prefs.setString(_keyUserName, name);
    await prefs.setString(_keyUserToken, token);
    await prefs.setBool(_keyIsLoggedIn, true);
  }

  static Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'id': prefs.getString(_keyUserId),
      'name': prefs.getString(_keyUserName),
      'token': prefs.getString(_keyUserToken),
    };
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyUserId);
    await prefs.remove(_keyUserName);
    await prefs.remove(_keyUserToken);
    await prefs.setBool(_keyIsLoggedIn, false);
  }
}
