part of 'kartu_antrean_bloc.dart';

@immutable
abstract class KartuAntreanState {
  const KartuAntreanState();
}

class KartuAntreanStateLoading extends KartuAntreanState {}

class KartuAntreanStateSuccess extends KartuAntreanState {
  final KartuAntrean kartuAntre;
  final String estimasi;
  KartuAntreanStateSuccess({@required this.kartuAntre, this.estimasi});
}

class KartuAntreanStateFailed extends KartuAntreanState {
  final String errMessage;
  KartuAntreanStateFailed({@required this.errMessage});
}

class KartuAntreanStateEmpty extends KartuAntreanState {
  final String message;
  KartuAntreanStateEmpty({@required this.message});
}

