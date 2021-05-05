part of 'profil_bloc.dart';

@immutable
abstract class ProfilState {
  const ProfilState();
}

class ProfilInitial extends ProfilState {}

class ProfilStateLogoutLoading extends ProfilState {}

class ProfilStateLogoutSuccess extends ProfilState {
  final String message;
  ProfilStateLogoutSuccess({@required this.message});
}

class ProfilStateLogoutFailed extends ProfilState {
  final String errMessage;
  ProfilStateLogoutFailed({@required this.errMessage});
}