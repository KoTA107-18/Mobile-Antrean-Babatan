import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/poliklinik.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'detail_poliklinik_event.dart';
part 'detail_poliklinik_state.dart';

class DetailPoliklinikBloc extends Bloc<DetailPoliklinikEvent, DetailPoliklinikState> {
  DetailPoliklinikBloc() : super(DetailPoliklinikStateLoading());
  List<Poliklinik> daftarPoli = [];
  Poliklinik poliklinikTujuan;
  String apiKey;

  @override
  Stream<DetailPoliklinikState> mapEventToState(
    DetailPoliklinikEvent event,
  ) async* {
    if(event is DetailPoliklinikEventGetPoli){
      yield DetailPoliklinikStateLoading();
      try{
        apiKey = await SharedPref.getApiKey();
        await RequestApi.getPoliklinik(apiKey, event.idPoli).then((snapshot) {
          if (snapshot != null) {
            var resultSnapshot = snapshot as List;
            daftarPoli = resultSnapshot
                .map((aJson) => Poliklinik.fromJson(aJson))
                .toList();
            poliklinikTujuan = daftarPoli[0];
          }
        });
        yield DetailPoliklinikStateSuccess(daftarPoli: daftarPoli[0]);
      } catch (e) {
        yield DetailPoliklinikStateFailed(errMessage: e.toString());
      }
    }
  }
}
