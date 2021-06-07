import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/JadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/utils/hari.dart';

part 'antre_event.dart';
part 'antre_state.dart';

class AntreBloc extends Bloc<AntreEvent, AntreState> {
  AntreBloc() : super(AntreStateGetPoliLoading());
  List<Poliklinik> daftarPoli = [];

  // Variabel Controller Input.
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();

  // Variabel Penampung Input.
  bool isBooking = false;
  Poliklinik poliklinikTujuan;
  int jenisPasien = 0;
  DateTime tanggalPelayanan;
  TimeOfDay jamBooking;

  @override
  Stream<AntreState> mapEventToState(
    AntreEvent event,
  ) async* {
    if (event is AntreEventGetPoliklinik) {
      yield AntreStateGetPoliLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
            poliklinikTujuan = daftarPoli[0];
          }
        });
        yield AntreStateGetPoliSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield AntreStateGetPoliFailed(errMessage: e.toString());
      }
    }

    if (event is AntreEventChooseType) {
      if (jenisPasien == 0) {
        jenisPasien = 1;
      } else {
        jenisPasien = 0;
      }
      yield AntreStateChooseType(daftarPoli: daftarPoli);
    }

    if (event is AntreEventChooseRegistType) {
      isBooking = !isBooking;
      yield AntreStateChooseRegistType(daftarPoli: daftarPoli);
    }

    if (event is AntreEventRegister) {
      yield AntreStateGetPoliLoading();
      JadwalPasien jadwalPasien;
      int idPasien = await SharedPref.getIdPasien();
      if (isBooking) {

      } else {
        tanggalPelayanan = DateTime.now();
        jadwalPasien = JadwalPasien(
            hari: convertNumDayToCode(tanggalPelayanan.weekday),
            idPoli: poliklinikTujuan.idPoli,
            idPasien: idPasien,
            tipeBooking: 0,
            jenisPasien: jenisPasien);
      }
    }
  }

  String convertNumDayToCode(int day) {
    List<String> codeDay = [
      Hari.SENIN,
      Hari.SELASA,
      Hari.RABU,
      Hari.KAMIS,
      Hari.JUMAT,
      Hari.SABTU,
      Hari.MINGGU
    ];
    return codeDay.elementAt(day - 1);
  }
}
