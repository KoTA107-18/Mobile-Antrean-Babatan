import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_antrean_babatan/model/pasien.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";
  static Future<List<dynamic>> getPasien() async {
    var result = await http.get(Uri.http(apiUrl, 'pasien'));
    return json.decode(result.body)['data'];
  }

  static Future<bool> registerPasien(Pasien pasien) async {
    var result =
        await http.post(Uri.http(apiUrl, 'api/register'), body: pasien.toJson());
    print(Uri.http(apiUrl, 'register').toString());
    print(result.statusCode);
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> loginPasienUsername(String username, String password) async {
    String api_token;
    var uri = Uri.http(apiUrl, 'api/login/username', {
      "username" : username,
      "password" : password
    });
    var result = await http.post(uri);
    if (result.statusCode == 201) {
      api_token = json.decode(result.body)['data']['api_token'];
      return api_token;
    } else {
      return null;
    }
  }
}
