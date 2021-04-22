class Pasien {
  String username;
  String no_handphone;
  String kepala_keluarga;
  String nama_lengkap;
  String password;
  String alamat;
  DateTime tgl_lahir;
  Pasien(
      {this.username,
      this.no_handphone,
      this.kepala_keluarga,
      this.nama_lengkap,
      this.password,
      this.alamat,
      this.tgl_lahir});
  factory Pasien.fromJson(Map<String, dynamic> map) {
    return Pasien(
        username: map["username"],
        no_handphone: map["no_handphone"],
        kepala_keluarga: map["kepala_keluarga"],
        nama_lengkap: map["nama_lengkap"],
        password: map["password"],
        alamat: map["alamat"],
        tgl_lahir: map["tgl_lahir"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "no_handphone": no_handphone,
      "kepala_keluarga": kepala_keluarga,
      "nama_lengkap": nama_lengkap,
      "password": password,
      "alamat": alamat,
      "tgl_lahir": tgl_lahir
    };
  }
}
