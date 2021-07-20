import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_antrean_babatan/dataLayer/api/api.dart';
import 'package:mobile_antrean_babatan/dataLayer/model/pasien.dart';
import 'package:mobile_antrean_babatan/dataLayer/session/sharedPref.dart';

part 'ubah_password_event.dart';
part 'ubah_password_state.dart';

class UbahPasswordBloc extends Bloc<UbahPasswordEvent, UbahPasswordState> {
  UbahPasswordBloc() : super(UbahPasswordInitial());
  String apiKey;

  @override
  Stream<UbahPasswordState> mapEventToState(
    UbahPasswordEvent event,
  ) async* {
    if(event is UbahPasswordEventSubmit){
      yield UbahPasswordLoading();
      try {
        apiKey = await SharedPref.getApiKey();
        var result = await RequestApi.updatePassword(event.pasien, apiKey);
        if (result) {
          yield UbahPasswordSuccess(successMessage: "Ubah Password berhasil!");
        } else {
          yield UbahPasswordFailed(errMessage: "Ubah Password gagal");
        }
      } catch (e) {
        yield UbahPasswordFailed(errMessage: e.toString());
      }
    }
  }
}
