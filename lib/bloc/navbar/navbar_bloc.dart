import 'dart:async';
import 'package:bloc/bloc.dart';

enum NavbarEvent { goDashboard, goTicket, goAntre, goRiwayat, goProfil }

class NavbarBloc extends Bloc<NavbarEvent, int> {
  NavbarBloc(int initialState) : super(initialState);

  @override
  Stream<int> mapEventToState(
    NavbarEvent event,
  ) async* {
    switch (event) {
      case NavbarEvent.goDashboard:
        yield 0;
        break;
      case NavbarEvent.goTicket:
        yield 1;
        break;
      case NavbarEvent.goAntre:
        yield 2;
        break;
      case NavbarEvent.goRiwayat:
        yield 3;
        break;
      case NavbarEvent.goProfil:
        yield 4;
        break;
    }
  }
}
