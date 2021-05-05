import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'riwayat_event.dart';
part 'riwayat_state.dart';

class RiwayatBloc extends Bloc<RiwayatEvent, RiwayatState> {
  RiwayatBloc() : super(RiwayatInitial());

  @override
  Stream<RiwayatState> mapEventToState(
    RiwayatEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
