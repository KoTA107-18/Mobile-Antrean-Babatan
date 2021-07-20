part of 'riwayat_bloc.dart';

@immutable
abstract class RiwayatState {
  const RiwayatState();
}

class RiwayatStateLoading extends RiwayatState {}

class RiwayatStateSuccess extends RiwayatState {
  List<KartuAntrean> jadwalPasien;
  RiwayatStateSuccess({this.jadwalPasien});
}

class RiwayatStateFailed extends RiwayatState {
  String errMessage;
  RiwayatStateFailed({this.errMessage});
}
