import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'detail_poliklinik_event.dart';
part 'detail_poliklinik_state.dart';

class DetailPoliklinikBloc extends Bloc<DetailPoliklinikEvent, DetailPoliklinikState> {
  DetailPoliklinikBloc() : super(DetailPoliklinikInitial());

  @override
  Stream<DetailPoliklinikState> mapEventToState(
    DetailPoliklinikEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
