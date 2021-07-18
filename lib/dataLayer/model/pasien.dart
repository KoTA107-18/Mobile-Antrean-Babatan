class Pasien {
  int idPasien;
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String namaLengkap;
  String password;
  String alamat;
  String tglLahir;
  Pasien(
      { this.idPasien,
        this.username,
        this.noHandphone,
        this.kepalaKeluarga,
        this.namaLengkap,
        this.password,
        this.alamat,
        this.tglLahir});
  factory Pasien.fromJson(Map<String, dynamic> map) {
    return Pasien(
        idPasien: int.parse(map["id_pasien"]),
        username: map["username"].toString(),
        noHandphone: map["no_handphone"].toString(),
        kepalaKeluarga: map["kepala_keluarga"].toString(),
        namaLengkap: map["nama_lengkap"].toString(),
        password: map["password"].toString(),
        alamat: map["alamat"].toString(),
        tglLahir: map["tgl_lahir"].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      "id_pasien": idPasien,
      "username": username,
      "no_handphone": noHandphone,
      "kepala_keluarga": kepalaKeluarga,
      "nama_lengkap": namaLengkap,
      "password": password,
      "alamat": alamat,
      "tgl_lahir": tglLahir
    };
  }
}
