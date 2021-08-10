part of 'detail_poliklinik_bloc.dart';

@immutable
abstract class DetailPoliklinikState {
  const DetailPoliklinikState();
}

class DetailPoliklinikStateLoading extends DetailPoliklinikState {}

class DetailPoliklinikStateFailed extends DetailPoliklinikState {
  String errMessage;
  DetailPoliklinikStateFailed({@required this.errMessage});
}

class DetailPoliklinikStateSuccess extends DetailPoliklinikState {
  Poliklinik daftarPoli;
  DetailPoliklinikStateSuccess({@required this.daftarPoli});
}
