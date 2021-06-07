import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String _apiKey = "API_KEY";
  static String _usernameKey = "USERNAME_KEY";
  static String _idPasienKey = "PASIEN_KEY";

  static Future<void> saveLoginInfo(String apiKey, String username, int idPasien) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_usernameKey, username);
    prefs.setString(_apiKey, apiKey);
    prefs.setInt(_idPasienKey, idPasien);
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString(_apiKey);
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
    String apiKey = prefs.getString(_apiKey);
    if (apiKey != null) {
      return apiKey;
    } else {
      return null;
    }
  }

  static Future<int> getIdPasien() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int result = prefs.getInt(_idPasienKey);
    return result;
  }

  static Future<void> deleteSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
