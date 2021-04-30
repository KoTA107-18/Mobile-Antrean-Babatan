class Poliklinik {
  int idPoli;
  String namaPoli;
  String descPoli;
  int statusPoli;
  int rerataWaktuPelayanan;
  Poliklinik(
      {this.idPoli,
      this.namaPoli,
      this.descPoli,
      this.statusPoli,
      this.rerataWaktuPelayanan});

  factory Poliklinik.fromJson(Map<String, dynamic> map) {
    return Poliklinik(
        idPoli: map["id_poli"],
        namaPoli: map["nama_poli"],
        descPoli: map["desc_poli"],
        statusPoli: map["status_poli"],
        rerataWaktuPelayanan: map["rerata_waktu_pelayanan"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id_poli": idPoli,
      "nama_poli": namaPoli,
      "desc_poli": descPoli,
      "status_poli": statusPoli,
      "rerata_waktu_pelayanan": rerataWaktuPelayanan
    };
  }
}
