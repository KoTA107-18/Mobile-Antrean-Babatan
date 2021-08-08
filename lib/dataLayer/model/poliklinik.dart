class Poliklinik {
  int idPoli;
  String namaPoli;
  String descPoli;
  String statusPoli;
  String rerataWaktuPelayanan;
  String batasBooking;
  List<Jadwal> jadwal;

  Poliklinik(
      {this.idPoli,
        this.namaPoli,
        this.descPoli,
        this.statusPoli,
        this.rerataWaktuPelayanan,
        this.batasBooking,
        this.jadwal});

  Poliklinik.fromJson(Map<String, dynamic> json) {
    idPoli = json['id_poli'];
    namaPoli = json['nama_poli'];
    descPoli = json['desc_poli'];
    statusPoli = json['status_poli'];
    rerataWaktuPelayanan = json['rerata_waktu_pelayanan'];
    batasBooking = json['batas_booking'];
    if (json['jadwal'] != null) {
      jadwal = new List<Jadwal>();
      json['jadwal'].forEach((v) {
        jadwal.add(new Jadwal.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_poli'] = this.idPoli;
    data['nama_poli'] = this.namaPoli;
    data['desc_poli'] = this.descPoli;
    data['status_poli'] = this.statusPoli;
    data['rerata_waktu_pelayanan'] = this.rerataWaktuPelayanan;
    data['batas_booking'] = this.batasBooking;
    if (this.jadwal != null) {
      data['jadwal'] = this.jadwal.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jadwal {
  String hari;
  String idPoli;
  String jamBukaBooking;
  String jamTutupBooking;

  Jadwal({this.hari, this.idPoli, this.jamBukaBooking, this.jamTutupBooking});

  Jadwal.fromJson(Map<String, dynamic> json) {
    hari = json['hari'];
    idPoli = json['id_poli'];
    jamBukaBooking = json['jam_buka_booking'];
    jamTutupBooking = json['jam_tutup_booking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hari'] = this.hari;
    data['id_poli'] = this.idPoli;
    data['jam_buka_booking'] = this.jamBukaBooking;
    data['jam_tutup_booking'] = this.jamTutupBooking;
    return data;
  }
}