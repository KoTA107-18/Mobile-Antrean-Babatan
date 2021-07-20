import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
  String apiKey;

  // Notifications.
  FlutterLocalNotificationsPlugin fltrNotification;

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

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);

    var scheduledTime = DateTime.now().add(Duration(seconds : 15));
    fltrNotification.schedule(1, "Times Up", "Habis",
        scheduledTime, generalNotificationDetails);
    /*
    await fltrNotification.show(
        0, "Task", "You created a Task",
        generalNotificationDetails, payload: "Task");*/
  }

  @override
  Stream<AntreState> mapEventToState(
    AntreEvent event,
  ) async* {
    if (event is AntreEventGetPoliklinik) {
      yield AntreStateGetPoliLoading();
      var androidInitilize = new AndroidInitializationSettings('app_icon');
      var iOSinitilize = new IOSInitializationSettings();
      var initilizationsSettings =
      new InitializationSettings(android: androidInitilize, iOS: iOSinitilize);
      fltrNotification = new FlutterLocalNotificationsPlugin();
      fltrNotification.initialize(initilizationsSettings,
          onSelectNotification: null);
      try {
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getAllPoliklinik(apiKey).then((snapshot) {
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
      yield AntreStateRegisterLoading(daftarPoli: daftarPoli);
      int idPasien = await SharedPref.getIdPasien();
      try {
        if (isBooking) {
          jadwalPasien = JadwalPasien(
              hari: convertNumDayToCode(tanggalPelayanan.weekday),
              idPoli: poliklinikTujuan.idPoli,
              idPasien: idPasien,
              tipeBooking: 1,
              latitude: latitudeData,
              longitude: longitudeData,
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
              latitude: latitudeData,
              longitude: longitudeData,
              jenisPasien: jenisPasien);
        }
        var resultSnapshot = await RequestApi.insertAntrean(jadwalPasien, apiKey);
        var response = ApiResponse.fromJson(resultSnapshot);
        if(response.success){
          _showNotification();
          yield AntreStateSendMessage(daftarPoli: daftarPoli, message: response.message);
        } else {
          yield AntreStateSendMessage(daftarPoli: daftarPoli, message: response.message);
        }
      } catch (e) {
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
