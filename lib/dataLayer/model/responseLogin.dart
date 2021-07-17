class ResponseLogin {
  bool success;
  String message;
  Data data;

  ResponseLogin({this.success, this.message, this.data});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'].toString();
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  PasienLogin pasien;
  String apiToken;

  Data({this.pasien, this.apiToken});

  Data.fromJson(Map<String, dynamic> json) {
    pasien = PasienLogin.fromJson(json['pasien']);
    apiToken = json['api_token'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pasien != null) {
      data['pasien'] = this.pasien.toJson();
    }
    data['api_token'] = this.apiToken;
    return data;
  }
}

class PasienLogin {
  int idPasien;
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String tglLahir;
  String alamat;
  String namaLengkap;
  int jenisPasien;

  PasienLogin(
      {this.idPasien,
        this.username,
        this.noHandphone,
        this.kepalaKeluarga,
        this.tglLahir,
        this.alamat,
        this.namaLengkap});

  PasienLogin.fromJson(Map<String, dynamic> json) {
    idPasien = int.parse(json['id_pasien']);
    username = json['username'].toString();
    noHandphone = json['no_handphone'].toString();
    kepalaKeluarga = json['kepala_keluarga'].toString();
    tglLahir = json['tgl_lahir'].toString();
    alamat = json['alamat'].toString();
    namaLengkap = json['nama_lengkap'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pasien'] = this.idPasien;
    data['username'] = this.username;
    data['no_handphone'] = this.noHandphone;
    data['kepala_keluarga'] = this.kepalaKeluarga;
    data['tgl_lahir'] = this.tglLahir;
    data['alamat'] = this.alamat;
    data['nama_lengkap'] = this.namaLengkap;
    return data;
  }
}