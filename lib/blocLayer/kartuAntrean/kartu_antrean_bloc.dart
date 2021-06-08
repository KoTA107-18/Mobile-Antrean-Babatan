import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'kartu_antrean_event.dart';
part 'kartu_antrean_state.dart';

class KartuAntreanBloc extends Bloc<KartuAntreanEvent, KartuAntreanState> {
  int idPasien;
  String messageError;
  JadwalPasien kartuAntre;
  KartuAntreanBloc() : super(KartuAntreanStateLoading());

  @override
  Stream<KartuAntreanState> mapEventToState(
    KartuAntreanEvent event,
  ) async* {
    if(event is KartuAntreanEventGetKartu){
      yield KartuAntreanStateLoading();
      try {
        idPasien = await SharedPref.getIdPasien();
        await RequestApi.getKartuAntrean(idPasien).then((value){
          if(value != null){
            kartuAntre = new JadwalPasien.fromJson(value[0]);
          }
        });
        if(kartuAntre == null){
          yield KartuAntreanStateEmpty(message: "Anda belum mengambil antrean.");
        } else {
          yield KartuAntreanStateSuccess(kartuAntre: kartuAntre);
        }
      } catch (e) {
        yield KartuAntreanStateFailed(errMessage: e.toString());
      }
    }

    if(event is KartuAntreanEventCancelAntrean){
      yield KartuAntreanStateLoading();
      try {
        bool result = false;
        kartuAntre.statusAntrean = 5;
        result = await RequestApi.updateJadwalPasien(kartuAntre);
        if(result){
          yield KartuAntreanStateEmpty(message: "Anda belum mengambil antrean.");
        } else {
          yield KartuAntreanStateSuccess(kartuAntre: kartuAntre);
        }
      } catch (e) {
        yield KartuAntreanStateFailed(errMessage: e.toString());
      }

    }
  }
}
