part of 'reset_password_bloc.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();
  @override
  List<Object> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {}
class ResetPasswordLoading extends ResetPasswordState {}
class ResetPasswordSuccess extends ResetPasswordState {
  final String msg;

  ResetPasswordSuccess({this.msg});
  @override
  List<Object> get props => [msg];
}
class ResetPasswordFailure extends ResetPasswordState {
  final String msg;

  ResetPasswordFailure({this.msg});

  @override
  List<Object> get props => [msg];
}
