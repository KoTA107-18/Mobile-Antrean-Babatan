part of 'ubah_password_bloc.dart';

@immutable
abstract class UbahPasswordEvent {
  const UbahPasswordEvent();
}

class UbahPasswordEventSubmit extends UbahPasswordEvent {
  Pasien pasien;
  UbahPasswordEventSubmit({this.pasien});
}
