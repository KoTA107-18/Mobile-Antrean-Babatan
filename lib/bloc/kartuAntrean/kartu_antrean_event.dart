part of 'kartu_antrean_bloc.dart';

@immutable
abstract class KartuAntreanEvent {
  const KartuAntreanEvent();
}

class KartuAntreanEventGetKartu extends KartuAntreanEvent {}

class KartuAntreanEventCancelAntrean extends KartuAntreanEvent {}
