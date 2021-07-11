part of 'kartu_riwayat_bloc.dart';

@immutable
abstract class KartuRiwayatState {
  const KartuRiwayatState();
}

class KartuRiwayatStateLoading extends KartuRiwayatState {}

class KartuRiwayatStateSuccess extends KartuRiwayatState {
  final JadwalPasien kartuAntre;
  KartuRiwayatStateSuccess({@required this.kartuAntre});
}

class KartuRiwayatStateFailed extends KartuRiwayatState {
  final String errMessage;
  KartuRiwayatStateFailed({@required this.errMessage});
}

class KartuRiwayatStateEmpty extends KartuRiwayatState {
  final String message;
  KartuRiwayatStateEmpty({@required this.message});
}
