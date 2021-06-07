part of 'antre_bloc.dart';

@immutable
abstract class AntreEvent {
  const AntreEvent();
}

class AntreEventGetPoliklinik extends AntreEvent {}

class AntreEventChooseType extends AntreEvent {}

class AntreEventChooseRegistType extends AntreEvent {}

class AntreEventRegister extends AntreEvent {}
