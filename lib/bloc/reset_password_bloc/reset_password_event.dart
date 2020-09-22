part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
  @override
  List<Object> get props => [];
}

class DoResetPassword extends ResetPasswordEvent {
  final String email;

  DoResetPassword({this.email});
  @override
  List<Object> get props => [email];
}