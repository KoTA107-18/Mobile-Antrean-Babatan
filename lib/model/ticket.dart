class Ticket {
  String username;
  int id_jadwal;
  int id_poli;
  int kode_antrean;
  bool tipe_booking;
  String tgl_pelayanan;
  String jam_mulai_dilayani;
  String jam_selesai_dilayani;
  int status_antrean;

  Ticket(
      {this.username,
      this.id_jadwal,
      this.id_poli,
      this.kode_antrean,
      this.tipe_booking,
      this.tgl_pelayanan,
      this.jam_mulai_dilayani,
      this.jam_selesai_dilayani,
      this.status_antrean});

  factory Ticket.fromJson(Map<String, dynamic> map) {
    return Ticket(
      username: map["id_poli"],
      id_jadwal: map["nama_poli"],
      id_poli: map["desc_poli"],
      kode_antrean: map["status_poli"],
      tipe_booking: map["rerata_waktu_pelayanan"],
      tgl_pelayanan: map["nama_poli"],
      jam_mulai_dilayani: map["desc_poli"],
      jam_selesai_dilayani: map["status_poli"],
      status_antrean: map["rerata_waktu_pelayanan"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "username": username.toString(),
      "id_jadwal": id_jadwal.toString(),
      "id_poli": id_poli.toString(),
      "kode_antrean": kode_antrean.toString(),
      "tipe_booking": tipe_booking.toString(),
      "tgl_pelayanan": tgl_pelayanan.toString(),
      "jam_mulai_dilayani": jam_mulai_dilayani.toString(),
      "jam_selesai_dilayani": jam_selesai_dilayani.toString(),
      "status_antrean": status_antrean.toString(),
    };
  }
}
