class Ticket {
  String username;
  int idJadwal;
  int idPoli;
  int kodeAntrean;
  bool tipeBooking;
  String tglPelayanan;
  String jamMulaiDilayani;
  String jamSelesaiDilayani;
  int statusAntrean;

  Ticket(
      {this.username,
      this.idJadwal,
      this.idPoli,
      this.kodeAntrean,
      this.tipeBooking,
      this.tglPelayanan,
      this.jamMulaiDilayani,
      this.jamSelesaiDilayani,
      this.statusAntrean});

  factory Ticket.fromJson(Map<String, dynamic> map) {
    return Ticket(
      username: map["id_poli"],
      idJadwal: map["nama_poli"],
      idPoli: map["desc_poli"],
      kodeAntrean: map["status_poli"],
      tipeBooking: map["rerata_waktu_pelayanan"],
      tglPelayanan: map["nama_poli"],
      jamMulaiDilayani: map["desc_poli"],
      jamSelesaiDilayani: map["status_poli"],
      statusAntrean: map["rerata_waktu_pelayanan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username.toString(),
      "id_jadwal": idJadwal.toString(),
      "id_poli": idPoli.toString(),
      "kode_antrean": kodeAntrean.toString(),
      "tipe_booking": tipeBooking.toString(),
      "tgl_pelayanan": tglPelayanan.toString(),
      "jam_mulai_dilayani": jamMulaiDilayani.toString(),
      "jam_selesai_dilayani": jamSelesaiDilayani.toString(),
      "status_antrean": statusAntrean.toString(),
    };
  }
}
