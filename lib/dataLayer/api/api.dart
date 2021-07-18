import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/jadwalPasien.dart';

class RequestApi {
  static final String apiUrl = "apibabatan.kota107.xyz";

  /*
    Method for functional Pasien.
  */

  static Future getPasien(int id) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/pasien/{id}
    Method Type : GET
    Desc : Get data pasien.
    */
    var uri = Uri.https(apiUrl, 'pasien/${id.toString()}');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future<bool> updateProfile(Pasien pasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/pasien
    Method Type : PUT
    Desc : Edit data diri.
    */
    var result = await http.put(Uri.http(apiUrl, 'pasien'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updatePassword(Pasien pasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/pasien/password
    Method Type : PUT
    Desc : Edit password.
    */
    var result = await http.put(Uri.http(apiUrl, 'pasien/password'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    if (result.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future validasiPasien(Pasien pasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/pasien/validasi
    Method Type : POST
    Desc : Validate Pasien not duplicate in Database
    */
    var uri = Uri.http(apiUrl, 'pasien/validasi');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(pasien.toJson()));
    return json.decode(result.body);
  }

  static Future registerPasien(Pasien pasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/api/pasien/register
    Method Type : POST
    Desc : Insert data Pasien into Database
    */
    var result = await http.post(Uri.http(apiUrl, 'api/pasien/register'),
        body: pasien.toJson());
    return json.decode(result.body);
  }

  static Future loginPasienUsername(String username, String password) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/api/pasien/login/username
    Method Type : POST
    Desc : Login with username, get API Token from API.
    */
    var uri = Uri.http(apiUrl, 'api/pasien/login/username',
        {"username": username, "password": password});
    var result = await http.post(uri);
    return json.decode(result.body);
  }

  static Future loginPasienHandphone(String noHandphone) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/api/pasien/login/nohp
    Method Type : POST
    Desc : Login with no Handphone, get API Token from API.
    */
    var uri = Uri.http(apiUrl, 'api/pasien/login/nohp',
        {"no_handphone": noHandphone});
    var result = await http.post(uri);
    return json.decode(result.body);
  }

  static Future logoutPasien(String apiToken) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/api/pasien/logout
    Method Type : POST
    Desc : Logout for delete API Token.
    */
    var uri = Uri.http(apiUrl, 'api/pasien/logout');
    var result =
        await http.post(uri, headers: {'Authorization': 'bearer $apiToken'});
    return json.decode(result.body);
  }

  /*
    Method for functional Jadwal Pasien.
  */

  static Future getAntreanEstimasi(JadwalPasien jadwalPasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/estimasi
    Method Type : GET
    Desc : Get estimate service.
    */
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

  static Future getAntreanRiwayat(String idPasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/pasien/riwayat/{id}
    Method Type : GET
    Desc : Get riwayat antrean pasien.
    */
    var uri = Uri.https(apiUrl, 'antrean/pasien/riwayat/$idPasien');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }

  static Future getKartuAntrean(int idPasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean/pasien/{id}
    Method Type : GET
    Desc : Get antrean active.
    */
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
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean
    Method Type : POST
    Desc : Insert new antrean
    */
    var uri = Uri.http(apiUrl, 'antrean');
    var result = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jadwalPasien.toJson()));
    return json.decode(result.body);
  }

  static Future<bool> updateAntrean(JadwalPasien jadwalPasien) async {
    /*
    Endpoint : rest-api-babatan.herokuapp.com/antrean
    Method Type : PUT
    Desc : Edit antrean to cancel status.
    */
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
    /*
    Endpoint : rest-api-babatan.herokuapp.com/poliklinik
    Method Type : GET
    Desc : Get All Poliklinik in Database + Jadwal
    */
    var uri = Uri.http(apiUrl, 'poliklinik');
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
    Desc : Get All Poliklinik in Database + Jadwal
    */
    var uri = Uri.https(apiUrl, 'antrean/info');
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      return json.decode(result.body);
    } else {
      return null;
    }
  }
}
