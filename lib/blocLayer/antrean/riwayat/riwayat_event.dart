part of 'riwayat_bloc.dart';

@immutable
abstract class RiwayatEvent {
  const RiwayatEvent();
}

class RiwayatEventGetJadwalPasien extends RiwayatEvent {}
