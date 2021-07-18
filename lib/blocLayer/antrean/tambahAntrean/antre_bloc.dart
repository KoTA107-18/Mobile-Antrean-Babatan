import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/apiResponse.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/hari.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/jadwalPasien.dart';

part 'antre_event.dart';
part 'antre_state.dart';

class AntreBloc extends Bloc<AntreEvent, AntreState> {
  AntreBloc() : super(AntreStateGetPoliLoading());
  List<Poliklinik> daftarPoli = [];

  // Variabel Controller Input.
  TextEditingController tanggal = TextEditingController();
  TextEditingController jam = TextEditingController();

  // Variabel Penampung Input.
  String latitudeData = "";
  String longitudeData = "";
  bool isBooking = false;
  Poliklinik poliklinikTujuan;
  JadwalPasien jadwalPasien;
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
            print(resultSnapshot.toString());
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
      yield AntreStateRegisterLoading(daftarPoli: daftarPoli);
      int idPasien = await SharedPref.getIdPasien();
      try {
        if (isBooking) {
          jadwalPasien = JadwalPasien(
              hari: convertNumDayToCode(tanggalPelayanan.weekday),
              idPoli: poliklinikTujuan.idPoli,
              idPasien: idPasien,
              tipeBooking: 1,
              jenisPasien: jenisPasien,
              tglPelayanan: tanggal.text,
              jamBooking: jam.text);
        } else {
          tanggalPelayanan = DateTime.now();
          jadwalPasien = JadwalPasien(
              hari: convertNumDayToCode(tanggalPelayanan.weekday),
              idPoli: poliklinikTujuan.idPoli,
              idPasien: idPasien,
              tipeBooking: 0,
              jenisPasien: jenisPasien);
        }
        var resultSnapshot = await RequestApi.insertAntrean(jadwalPasien);
        var response = ApiResponse.fromJson(resultSnapshot);
        print("ERROR : " + response.message.toString());
        yield AntreStateSendMessage(daftarPoli: daftarPoli, message: response.message);
      } catch (e) {
        print("ERROR : " + e.toString());
        yield AntreStateSendMessage(daftarPoli: daftarPoli, message: e.toString());
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
