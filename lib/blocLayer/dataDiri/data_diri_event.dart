part of 'data_diri_bloc.dart';

@immutable
abstract class DataDiriEvent {
  const DataDiriEvent();
}

class DataDiriEventGetProfile extends DataDiriEvent {}

class DataDiriEventEditProfile extends DataDiriEvent {
  Pasien pasien;
  DataDiriEventEditProfile({@required this.pasien});
}