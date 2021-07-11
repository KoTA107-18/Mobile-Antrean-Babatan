import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'data_diri_event.dart';
part 'data_diri_state.dart';

class DataDiriBloc extends Bloc<DataDiriEvent, DataDiriState> {
  DataDiriBloc() : super(DataDiriInitial());

  @override
  Stream<DataDiriState> mapEventToState(
    DataDiriEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
