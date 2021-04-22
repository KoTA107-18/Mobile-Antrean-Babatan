import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";
  static Future<List<dynamic>> getPasien() async {
    var result = await http.get(Uri.http(apiUrl, 'pasien'));
    return json.decode(result.body)['data'];
  }

  static Future<bool> registerPasien() async {
    var result = await http.post(Uri.http(apiUrl, 'pasien'));
    //print(json.decode(result.body)['response']);
    print(result.body);
    return true;
  }
}
