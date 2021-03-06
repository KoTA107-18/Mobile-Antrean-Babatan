import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'profil_event.dart';
part 'profil_state.dart';

class ProfilBloc extends Bloc<ProfilEvent, ProfilState> {
  String apiKey;
  ProfilBloc() : super(ProfilInitial());

  @override
  Stream<ProfilState> mapEventToState(
    ProfilEvent event,
  ) async* {
    if (event is ProfilEventLogout) {
      yield ProfilStateLogoutLoading();
      try {
        apiKey = await SharedPref.getApiKey();
        var result = await RequestApi.logoutPasien(apiKey);
        if (result != null) {
          await FirebaseAuth.instance.signOut();
          await SharedPref.deleteSharedPref();
          yield ProfilStateLogoutSuccess(message: "Logout berhasil!");
        } else {
          yield ProfilStateLogoutFailed(errMessage: "Logout gagal");
        }
      } catch (e) {
        yield ProfilStateLogoutFailed(errMessage: e.toString());
      }
    }
  }
}
