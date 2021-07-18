part of 'ubah_password_bloc.dart';

@immutable
abstract class UbahPasswordState {
  const UbahPasswordState();
}

class UbahPasswordInitial extends UbahPasswordState {}

class UbahPasswordSuccess extends UbahPasswordState {
  String successMessage;
  UbahPasswordSuccess({this.successMessage});
}

class UbahPasswordFailed extends UbahPasswordState {
  String errMessage;
  UbahPasswordFailed({this.errMessage});
}

class UbahPasswordLoading extends UbahPasswordState {}
