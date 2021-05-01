import 'dart:async';

import 'package:bloc/bloc.dart';

enum BookingEvent { pilihHariIni, pilihBooking }

class BookingBloc extends Bloc<BookingEvent, bool> {
  BookingBloc(bool initialState) : super(false);

  @override
  Stream<bool> mapEventToState(
    BookingEvent event,
  ) async* {
    switch (event) {
      case BookingEvent.pilihHariIni:
        yield false;
        break;
      case BookingEvent.pilihBooking:
        yield true;
        break;
    }
  }
}
