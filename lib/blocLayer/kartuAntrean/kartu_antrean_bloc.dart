import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/kartu.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'kartu_antrean_event.dart';
part 'kartu_antrean_state.dart';

class KartuAntreanBloc extends Bloc<KartuAntreanEvent, KartuAntreanState> {
  String username;
  String messageError;
  KartuAntre kartuAntre;
  KartuAntreanBloc() : super(KartuAntreanStateLoading());

  @override
  Stream<KartuAntreanState> mapEventToState(
    KartuAntreanEvent event,
  ) async* {
    if(event is KartuAntreanEventGetKartu){
      yield KartuAntreanStateLoading();
      try {
        username = await SharedPref.getUsername();
        await RequestApi.getTicket(username).then((value){
          if(value != null){
            kartuAntre = new KartuAntre.fromJson(value[0]);
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
        kartuAntre.statusAntrean = 4;
        result = await RequestApi.updateStatusTicket(kartuAntre);
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
