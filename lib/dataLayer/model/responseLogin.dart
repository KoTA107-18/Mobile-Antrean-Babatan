class ResponseLogin {
  bool success;
  String message;
  Data data;

  ResponseLogin({this.success, this.message, this.data});

  ResponseLogin.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
    pasien =
    json['pasien'] != null ? new PasienLogin.fromJson(json['pasien']) : null;
    apiToken = json['api_token'];
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
        this.namaLengkap,
        this.jenisPasien});

  PasienLogin.fromJson(Map<String, dynamic> json) {
    idPasien = json['id_pasien'];
    username = json['username'];
    noHandphone = json['no_handphone'];
    kepalaKeluarga = json['kepala_keluarga'];
    tglLahir = json['tgl_lahir'];
    alamat = json['alamat'];
    namaLengkap = json['nama_lengkap'];
    jenisPasien = json['jenis_pasien'];
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
    data['jenis_pasien'] = this.jenisPasien;
    return data;
  }
}