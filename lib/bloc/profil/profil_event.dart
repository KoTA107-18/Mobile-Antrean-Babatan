part of 'profil_bloc.dart';

@immutable
abstract class ProfilEvent {
  const ProfilEvent();
}

class ProfilEventLogout extends ProfilEvent {}
