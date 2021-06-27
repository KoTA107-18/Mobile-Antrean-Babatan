part of 'antre_bloc.dart';

@immutable
abstract class AntreState {}

class AntreStateGetPoliLoading extends AntreState {}

class AntreStateGetPoliSuccess extends AntreState {
  List<Poliklinik> daftarPoli;
  AntreStateGetPoliSuccess({@required this.daftarPoli});
}

class AntreStateGetPoliFailed extends AntreState {
  String errMessage;
  AntreStateGetPoliFailed({@required this.errMessage});
}

class AntreStateChooseType extends AntreState {
  List<Poliklinik> daftarPoli;
  AntreStateChooseType({@required this.daftarPoli});
}

class AntreStateChooseRegistType extends AntreState {
  List<Poliklinik> daftarPoli;
  AntreStateChooseRegistType({@required this.daftarPoli});
}

class AntreStateRegisterLoading extends AntreState {
  List<Poliklinik> daftarPoli;
  AntreStateRegisterLoading({@required this.daftarPoli});
}

class AntreStateSendMessage extends AntreState {
  List<Poliklinik> daftarPoli;
  String message;
  AntreStateSendMessage({@required this.daftarPoli, this.message});
}

