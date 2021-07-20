import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartuAntrean.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'kartu_antrean_event.dart';
part 'kartu_antrean_state.dart';

class KartuAntreanBloc extends Bloc<KartuAntreanEvent, KartuAntreanState> {
  String apiKey;
  int idPasien;
  String messageError;
  KartuAntrean kartuAntre;
  var estimasi;
  KartuAntreanBloc() : super(KartuAntreanStateLoading());

  // Notifications.
  FlutterLocalNotificationsPlugin fltrNotification;

  Future _showNotification(KartuAntrean jadwalPasien, String estimasi) async {
    var androidDetails = new AndroidNotificationDetails(
        "ID", "UPT Puskesmas Babatan", "Notifikasi Antrean",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iSODetails);

    if (jadwalPasien.tipeBooking == 0.toString()) {
      await fltrNotification.show(
          int.parse(jadwalPasien.idPasien),
          jadwalPasien.poliklinik.namaPoli,
          "Estimasi antrean anda pada pukul  ${estimasi} WIB",
          generalNotificationDetails,
          payload: "Task");
    } else {
      var scheduledTime = DateTime.parse(jadwalPasien.tglPelayanan);
      if ((scheduledTime.day == DateTime.now().day) &&
          (scheduledTime.month == DateTime.now().month) &&
          (scheduledTime.year == DateTime.now().year)) {
        fltrNotification.show(
            int.parse(jadwalPasien.idPasien),
            jadwalPasien.poliklinik.namaPoli,
            "Estimasi antrean anda pada pukul ${estimasi} WIB",
            generalNotificationDetails);
      }
    }
  }

  @override
  Stream<KartuAntreanState> mapEventToState(
    KartuAntreanEvent event,
  ) async* {
    if (event is KartuAntreanEventGetKartu) {
      yield KartuAntreanStateLoading();
      try {
        idPasien = await SharedPref.getIdPasien();
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getKartuAntrean(idPasien, apiKey).then((value) {
          if (value != null) {
            print(value);
            kartuAntre = new KartuAntrean.fromJson(value[0]);
          }
        });
        if (kartuAntre == null) {
          yield KartuAntreanStateEmpty(
              message: "Anda belum mengambil antrean.");
        } else {
          idPasien = await SharedPref.getIdPasien();
          apiKey = await SharedPref.getApiKey();
          estimasi = await RequestApi.getAntreanEstimasi(kartuAntre, apiKey);
          yield KartuAntreanStateSuccess(
              kartuAntre: kartuAntre, estimasi: estimasi);
        }
      } catch (e) {
        yield KartuAntreanStateFailed(errMessage: e.toString());
      }
    }

    if (event is KartuAntreanEventCancelAntrean) {
      yield KartuAntreanStateLoading();
      try {
        bool result = false;
        kartuAntre.statusAntrean = 5.toString();
        apiKey = await SharedPref.getApiKey();
        result = await RequestApi.updateAntrean(kartuAntre, apiKey);
        if (result) {
          yield KartuAntreanStateEmpty(
              message: "Anda belum mengambil antrean.");
        } else {
          yield KartuAntreanStateSuccess(kartuAntre: kartuAntre);
        }
      } catch (e) {
        yield KartuAntreanStateFailed(errMessage: e.toString());
      }
    }

    if (event is KartuAntreanEventGetKartuSilent) {
      KartuAntrean kartuAntreBaru;
      var androidInitilize = new AndroidInitializationSettings('app_icon');
      var iOSinitilize = new IOSInitializationSettings();
      var initilizationsSettings = new InitializationSettings(
          android: androidInitilize, iOS: iOSinitilize);
      fltrNotification = new FlutterLocalNotificationsPlugin();
      fltrNotification.initialize(initilizationsSettings,
          onSelectNotification: null);
      try {
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getKartuAntrean(idPasien, apiKey).then((value) {
          if (value != null) {
            kartuAntreBaru = new KartuAntrean.fromJson(value[0]);
          }
        });
        if (kartuAntreBaru == null) {
          yield KartuAntreanStateEmpty(
              message: "Anda belum mengambil antrean.");
        } else {
          apiKey = await SharedPref.getApiKey();
          var estimasiNew =
              await RequestApi.getAntreanEstimasi(kartuAntreBaru, apiKey);
          estimasi = estimasiNew;
          kartuAntre = kartuAntreBaru;
          _showNotification(kartuAntre, estimasi);
          yield KartuAntreanStateSuccess(
              kartuAntre: kartuAntre, estimasi: estimasi);
        }
      } catch (e) {
        _showNotification(kartuAntre, estimasi);
        yield KartuAntreanStateSuccess(
            kartuAntre: kartuAntre, estimasi: estimasi);
      }
    }
  }
}
