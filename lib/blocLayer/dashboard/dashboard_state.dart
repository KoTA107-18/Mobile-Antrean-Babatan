part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {
  const DashboardState();
}

class DashboardStateLoading extends DashboardState {}

class DashboardStateSuccess extends DashboardState {
  final List<Poliklinik> daftarPoli;
  DashboardStateSuccess({@required this.daftarPoli});
}

class DashboardStateFailed extends DashboardState {
  final String messageFailed;
  DashboardStateFailed({@required this.messageFailed});
}