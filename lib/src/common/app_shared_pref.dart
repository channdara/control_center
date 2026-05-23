import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  AppSharedPref._();

  static SharedPreferences? _preferences;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static void dispose() {
    _preferences = null;
  }

  static Future<void> saveString(String key, String? value) async {
    if (value == null) return;
    await _preferences?.setString(key, value);
  }

  static String loadString(String key) => _preferences?.getString(key) ?? '';
}
