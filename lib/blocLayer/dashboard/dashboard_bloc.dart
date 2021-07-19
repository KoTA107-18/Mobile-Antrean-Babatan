import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/InfoPoliklinik.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  String apiKey;
  String messageError;
  List<InfoPoliklinik> daftarPoli = [];
  DashboardBloc() : super(DashboardStateLoading());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is DashboardEventGetPoli){
      yield DashboardStateLoading();
      try {
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getInfoPoliklinik(apiKey).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => InfoPoliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield DashboardStateSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield DashboardStateFailed(messageFailed: e.toString());
      }
    }

    if(event is DashboardEventGetPoliSilent){
      List<InfoPoliklinik> daftarPoliNew = [];
      try {
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getInfoPoliklinik(apiKey).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoliNew = resultSnapshot
                .map((aJson) => InfoPoliklinik.fromJson(aJson))
                .toList();
            daftarPoli = daftarPoliNew;
          }
        });
        yield DashboardStateSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield DashboardStateSuccess(daftarPoli: daftarPoli);
      }
    }
  }
}
