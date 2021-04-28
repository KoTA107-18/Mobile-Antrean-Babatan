import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String _ApiKey = "API_KEY";
  static String _usernameKey = "USERNAME_KEY";

  static Future<void> saveLoginInfo(String apiKey, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_usernameKey, username);
    prefs.setString(_ApiKey, apiKey);
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString(_ApiKey);
    String usernameKey = prefs.getString(_usernameKey);
    if ((apiKey != null) && (usernameKey != null)) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String usernameKey = prefs.getString(_usernameKey);
    if (usernameKey != null) {
      return usernameKey;
    } else {
      return null;
    }
  }

  static Future<String> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString(_ApiKey);
    if (apiKey != null) {
      return apiKey;
    } else {
      return null;
    }
  }

  static Future<void> deleteSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
