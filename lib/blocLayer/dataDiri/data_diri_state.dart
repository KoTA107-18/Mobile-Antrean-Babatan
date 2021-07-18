part of 'data_diri_bloc.dart';

@immutable
abstract class DataDiriState {
  const DataDiriState();
}

class DataDiriStateLoading extends DataDiriState {}

class DataDiriStateSuccess extends DataDiriState {
  final Pasien pasien;
  DataDiriStateSuccess({@required this.pasien});
}

class DataDiriStateFailed extends DataDiriState {
  final String messageFailed;
  DataDiriStateFailed({@required this.messageFailed});
}
