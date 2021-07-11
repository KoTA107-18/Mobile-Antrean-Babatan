import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/jadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'kartu_riwayat_event.dart';
part 'kartu_riwayat_state.dart';

class KartuRiwayatBloc extends Bloc<KartuRiwayatEvent, KartuRiwayatState> {
  KartuRiwayatBloc() : super(KartuRiwayatStateLoading());
  int idPasien;
  String messageError;
  JadwalPasien kartuAntre;

  @override
  Stream<KartuRiwayatState> mapEventToState(
    KartuRiwayatEvent event,
  ) async* {
    if(event is KartuRiwayatEventGetKartu){
      yield KartuRiwayatStateLoading();
      try {
        idPasien = await SharedPref.getIdPasien();
        await RequestApi.getKartuAntrean(idPasien).then((value){
          if(value != null){
            kartuAntre = new JadwalPasien.fromJson(value[0]);
          }
        });
        if(kartuAntre == null){
          yield KartuRiwayatStateEmpty(message: "Anda belum mengambil antrean.");
        } else {
          yield KartuRiwayatStateSuccess(kartuAntre: kartuAntre);
        }
      } catch (e) {
        yield KartuRiwayatStateFailed(errMessage: e.toString());
      }
    }
  }
}
