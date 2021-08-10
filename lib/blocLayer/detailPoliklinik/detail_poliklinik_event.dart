part of 'detail_poliklinik_bloc.dart';

@immutable
abstract class DetailPoliklinikEvent {
  const DetailPoliklinikEvent();
}

class DetailPoliklinikEventGetPoli extends DetailPoliklinikEvent {
  String idPoli;
  DetailPoliklinikEventGetPoli({@required this.idPoli});
}
