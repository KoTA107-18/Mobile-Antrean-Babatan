part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent();
}

class DashboardEventGetPoli extends DashboardEvent {}

class DashboardEventGetPoliSilent extends DashboardEvent {}
