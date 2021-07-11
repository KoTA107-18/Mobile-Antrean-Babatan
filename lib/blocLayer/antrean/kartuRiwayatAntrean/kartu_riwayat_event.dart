part of 'kartu_riwayat_bloc.dart';

@immutable
abstract class KartuRiwayatEvent {
  const KartuRiwayatEvent();
}

class KartuRiwayatEventGetKartu extends KartuRiwayatEvent {}