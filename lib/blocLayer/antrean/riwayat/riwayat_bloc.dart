import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/JadwalPasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartuAntrean.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'riwayat_event.dart';
part 'riwayat_state.dart';

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  String apiKey;
  List<KartuAntrean> jadwalPasien = [];
  RiwayatBloc() : super(RiwayatStateLoading());

  @override
  Stream<RiwayatState> mapEventToState(
    RiwayatEvent event,
  ) async* {
    if(event is RiwayatEventGetJadwalPasien){
      yield RiwayatStateLoading();
      try {
        var idPasien = await SharedPref.getIdPasien();
        idPasien = await SharedPref.getIdPasien();
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getAntreanRiwayat(idPasien.toString(), apiKey).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            jadwalPasien = resultSnapshot
                .map((aJson) => KartuAntrean.fromJson(aJson))
                .toList();
          }
        });
        yield RiwayatStateSuccess(jadwalPasien: jadwalPasien);
      } catch (e) {
        yield RiwayatStateFailed(errMessage: e.toString());
      }
    }
  }
}
