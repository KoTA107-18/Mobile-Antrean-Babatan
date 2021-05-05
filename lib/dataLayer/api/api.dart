import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartu.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";
  static Future<List<dynamic>> getPasien() async {
    var result = await http.get(Uri.http(apiUrl, 'pasien'));
    return json.decode(result.body)['data'];
  }

  static Future<bool> registerPasien(Pasien pasien) async {
    var result = await http.post(Uri.http(apiUrl, 'api/pasien/register'),
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
    var uri = Uri.http(apiUrl, 'api/pasien/login/username',
        {"username": username, "password": password});
    var result = await http.post(uri);
    if (result.statusCode == 201) {
      apiToken = json.decode(result.body)['data']['api_token'];
      print(apiToken);
      return apiToken;
    } else {
      return null;
    }
  }

  static Future logoutPasien(
      String apiToken) async {
    var uri = Uri.http(apiUrl, 'api/pasien/logout');
    var result = await http.post(uri, headers: {
      'Authorization' : 'bearer $apiToken'
    });
    if (result.statusCode == 200) {
      return true;
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

  static Future getTicket(String username) async {
    var uri = Uri.http(apiUrl, 'ticket/check', {"username": username});
    var result = await http.get(uri);
    print(result.statusCode);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> registerAntreanHariIni(KartuAntre ticket) async {
    var result = await http.post(Uri.http(apiUrl, 'ticket/daftar'),
        body: ticket.toJson());
    print(result.statusCode);
    print(result.body);

    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateStatusTicket(KartuAntre ticket) async {
    var result =
        await http.put(Uri.http(apiUrl, 'ticket/ubah'), body: ticket.toJson());
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
