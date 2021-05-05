import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/repositories/api/api.dart';
import 'package:mobile_antrean_babatan/repositories/model/poliklinik.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  String messageError;
  List<Poliklinik> daftarPoli = [];
  DashboardBloc() : super(DashboardStateLoading());

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if(event is DashboardEventGetPoli){
      yield DashboardStateLoading();
      try {
        await RequestApi.getAllPoliklinik().then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
          }
        });
        yield DashboardStateSuccess(daftarPoli: daftarPoli);
      } catch (e) {
        yield DashboardStateFailed(messageFailed: e.toString());
      }
    }
  }
}
