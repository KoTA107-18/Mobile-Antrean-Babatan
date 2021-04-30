import 'dart:async';

import 'package:bloc/bloc.dart';

enum RadioEvent { jenisUmum, jenisBPJS }

class RadioBloc extends Bloc<RadioEvent, int> {
  RadioBloc(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(
    RadioEvent event,
  ) async* {
    switch (event) {
      case RadioEvent.jenisUmum:
        yield 0;
        break;
      case RadioEvent.jenisBPJS:
        yield 1;
        break;
    }
  }
}
