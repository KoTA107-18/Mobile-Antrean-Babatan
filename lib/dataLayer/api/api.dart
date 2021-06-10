import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/jadwalPasien.dart';

class RequestApi {
  static final String apiUrl = "rest-api-babatan.herokuapp.com";

  /*
    Method for functional Pasien.
  */
  static Future validasiPasien(Pasien pasien) async {
    var uri = Uri.http(apiUrl, 'pasien/validasi');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    return json.decode(result.body);
  }

  static Future registerPasien(Pasien pasien) async {
    var result = await http.post(Uri.http(apiUrl, 'api/pasien/register'),
        body: pasien.toJson());
    return json.decode(result.body);
  }

  static Future loginPasienUsername(String username, String password) async {
    var uri = Uri.http(apiUrl, 'api/pasien/login/username',
        {"username": username, "password": password});
    var result = await http.post(uri);
    return json.decode(result.body);
  }

  static Future loginPasienHandphone(String noHandphone) async {
    var uri = Uri.http(apiUrl, 'api/pasien/login/nohp',
        {"no_handphone": noHandphone});
    var result = await http.post(uri);
    return json.decode(result.body);
  }

  static Future logoutPasien(String apiToken) async {
    var uri = Uri.http(apiUrl, 'api/pasien/logout');
    var result =
        await http.post(uri, headers: {'Authorization': 'bearer $apiToken'});
    return json.decode(result.body);
  }

  /*
    Method for functional Jadwal Pasien.
  */

  static Future getEstimasi(JadwalPasien jadwalPasien) async {
    var uri = Uri.https(apiUrl, 'antrean/estimasi', {
      'id_poli': jadwalPasien.idPoli.toString(),
      'tgl_pelayanan': jadwalPasien.tglPelayanan.toString(),
      'jam_booking': jadwalPasien.jamBooking.toString()
    });
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getInfoPoliklinik() async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/info
    Method Type : GET
    Desc : Get All Poliklinik in Database
    */
    var uri = Uri.https(apiUrl, 'antrean/info');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getAntreanRiwayat(String idPasien) async {
    var uri = Uri.https(apiUrl, 'antrean/pasien/riwayat/$idPasien');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getKartuAntrean(int idPasien) async {
    var uri = Uri.http(apiUrl, 'antrean/pasien/${idPasien.toString()}');
    var result = await http.get(uri);
    print(result.statusCode);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future insertAntrean(JadwalPasien jadwalPasien) async {
    var uri = Uri.http(apiUrl, 'antrean');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jadwalPasien.toJson()));
    return json.decode(result.body);
  }

  static Future<bool> registerAntreanHariIni(JadwalPasien ticket) async {
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

  static Future<bool> updateJadwalPasien(JadwalPasien jadwalPasien) async {
    var result = await http.put(Uri.http(apiUrl, 'antrean'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jadwalPasien.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /*
    Method for functional Poliklinik.
  */

  static Future getAllPoliklinik() async {
    var uri = Uri.http(apiUrl, 'poliklinik');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }
}
