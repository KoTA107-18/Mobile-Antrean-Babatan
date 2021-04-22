import 'dart:convert';
import 'package:http/http.dart' as http;

class RequestApi {
  final String apiUrl = "rest-api-babatan.herokuapp.com";
  Future<List<dynamic>> getPasien() async {
    var result = await http.get(Uri.http(apiUrl, 'pasien'));
    return json.decode(result.body)['data'];
  }

  Future<bool> registerPasien() async {
    var result = await http.post(Uri.http(apiUrl, 'pasien'));
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
