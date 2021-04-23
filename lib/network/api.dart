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
        await http.post(Uri.http(apiUrl, 'pasien'), body: pasien.toJson());
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
