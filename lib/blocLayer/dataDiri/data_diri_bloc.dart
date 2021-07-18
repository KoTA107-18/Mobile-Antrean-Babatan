import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'data_diri_event.dart';
part 'data_diri_state.dart';

class DataDiriBloc extends Bloc<DataDiriEvent, DataDiriState> {
  Pasien pasien;
  int idPasien;
  DataDiriBloc() : super(DataDiriStateLoading());

  @override
  Stream<DataDiriState> mapEventToState(
    DataDiriEvent event,
  ) async* {
    if(event is DataDiriEventGetProfile){
      yield DataDiriStateLoading();
      try {
        idPasien = await SharedPref.getIdPasien();
        await RequestApi.getPasien(idPasien).then((snapshot) {
          if (snapshot != null) {
            pasien = Pasien.fromJson(snapshot[0]);
          }
        });
        yield DataDiriStateSuccess(pasien: pasien);
      } catch (e) {
        yield DataDiriStateFailed(messageFailed: e.toString());
      }
    }

    if(event is DataDiriEventEditProfile){
      yield DataDiriStateLoading();
      try {
        event.pasien.idPasien = idPasien;
        var result = await RequestApi.updateProfile(event.pasien);
        yield DataDiriStateSuccess(pasien: event.pasien);
      } catch (e) {
        yield DataDiriStateFailed(messageFailed: e.toString());
      }
    }
  }
}
