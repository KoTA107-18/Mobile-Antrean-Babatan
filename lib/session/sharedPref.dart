import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String _ApiKey = "API_KEY";

  static Future<void> saveApiKey(String apiKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_ApiKey, apiKey);
  }

  static Future<bool> isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String apiKey = prefs.getString(_ApiKey);
    if(apiKey != null){
      return true;
    } else {
      return false;
    }
  }

  static Future<void> deleteSharedPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
