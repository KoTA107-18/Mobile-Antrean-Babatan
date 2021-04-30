import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_antrean_babatan/repositories/model/pasien.dart';
import 'package:mobile_antrean_babatan/repositories/model/ticket.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";
  static Future<List<dynamic>> getPasien() async {
    var result = await http.get(Uri.http(apiUrl, 'pasien'));
    return json.decode(result.body)['data'];
  }

  static Future<bool> registerAntreanHariIni(Ticket ticket) async {
    var result = await http.post(Uri.http(apiUrl, 'ticket/daftar'),
        body: ticket.toJson());
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> registerPasien(Pasien pasien) async {
    var result = await http.post(Uri.http(apiUrl, 'api/register'),
        body: pasien.toJson());
    if (result.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> loginPasienUsername(
      String username, String password) async {
    String apiToken;
    var uri = Uri.http(apiUrl, 'api/login/username',
        {"username": username, "password": password});
    var result = await http.post(uri);
    if (result.statusCode == 201) {
      apiToken = json.decode(result.body)['data']['api_token'];
      return apiToken;
    } else {
      return null;
    }
  }

  static Future getAllPoliklinik() async {
    var uri = Uri.http(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> checkAlreadyRegisterQueue(String username) async {
    var uri = Uri.http(apiUrl, 'ticket/check', {"username": username});
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}