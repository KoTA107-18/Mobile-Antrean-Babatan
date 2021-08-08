class KartuAntrean {
  String idPoli;
  String idPasien;
  String nomorAntrean;
  String tipeBooking;
  String tglPelayanan;
  String jamBooking;
  String waktuDaftarAntrean;
  String jamMulaiDilayani;
  String jamSelesaiDilayani;
  String statusAntrean;
  String hari;
  PasienKartu pasien;
  PoliklinikKartu poliklinik;

  KartuAntrean(
      {this.idPoli,
        this.idPasien,
        this.nomorAntrean,
        this.tipeBooking,
        this.tglPelayanan,
        this.jamBooking,
        this.waktuDaftarAntrean,
        this.jamMulaiDilayani,
        this.jamSelesaiDilayani,
        this.statusAntrean,
        this.hari,
        this.pasien,
        this.poliklinik});

  KartuAntrean.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    idPasien = json['id_pasien'];
    nomorAntrean = json['nomor_antrean'];
    tipeBooking = json['tipe_booking'];
    tglPelayanan = json['tgl_pelayanan'];
    jamBooking = json['jam_booking'];
    waktuDaftarAntrean = json['waktu_daftar_antrean'];
    jamMulaiDilayani = json['jam_mulai_dilayani'];
    jamSelesaiDilayani = json['jam_selesai_dilayani'];
    statusAntrean = json['status_antrean'];
    hari = json['hari'];
    pasien =
    json['pasien'] != null ? new PasienKartu.fromJson(json['pasien']) : null;
    poliklinik = json['poliklinik'] != null
        ? new PoliklinikKartu.fromJson(json['poliklinik'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['id_pasien'] = this.idPasien;
    data['nomor_antrean'] = this.nomorAntrean;
    data['tipe_booking'] = this.tipeBooking;
    data['tgl_pelayanan'] = this.tglPelayanan;
    data['jam_booking'] = this.jamBooking;
    data['waktu_daftar_antrean'] = this.waktuDaftarAntrean;
    data['jam_mulai_dilayani'] = this.jamMulaiDilayani;
    data['jam_selesai_dilayani'] = this.jamSelesaiDilayani;
    data['status_antrean'] = this.statusAntrean;
    data['hari'] = this.hari;
    if (this.pasien != null) {
      data['pasien'] = this.pasien.toJson();
    }
    if (this.poliklinik != null) {
      data['poliklinik'] = this.poliklinik.toJson();
    }
    return data;
  }
}

class PasienKartu {
  int idPasien;
  String username;
  String noHandphone;
  String kepalaKeluarga;
  String namaLengkap;
  String alamat;
  String tglLahir;
  Null jenisPasien;

  PasienKartu(
      {this.idPasien,
        this.username,
        this.noHandphone,
        this.kepalaKeluarga,
        this.namaLengkap,
        this.alamat,
        this.tglLahir,
        this.jenisPasien});

  PasienKartu.fromJson(Map<String, dynamic> json) {
    idPasien = json['id_pasien'];
    username = json['username'];
    noHandphone = json['no_handphone'];
    kepalaKeluarga = json['kepala_keluarga'];
    namaLengkap = json['nama_lengkap'];
    alamat = json['alamat'];
    tglLahir = json['tgl_lahir'];
    jenisPasien = json['jenis_pasien'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_pasien'] = this.idPasien;
    data['username'] = this.username;
    data['no_handphone'] = this.noHandphone;
    data['kepala_keluarga'] = this.kepalaKeluarga;
    data['nama_lengkap'] = this.namaLengkap;
    data['alamat'] = this.alamat;
    data['tgl_lahir'] = this.tglLahir;
    data['jenis_pasien'] = this.jenisPasien;
    return data;
  }
}

class PoliklinikKartu {
  int idPoli;
  String namaPoli;

  PoliklinikKartu({this.idPoli, this.namaPoli});

  PoliklinikKartu.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    return data;
  }
}