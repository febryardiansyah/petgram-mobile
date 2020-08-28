part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
  @override
  List<Object> get props => [];
}

class SignInBtnPressed extends SignInEvent{
  final String email;
  final String passwod;
  SignInBtnPressed({this.email, this.passwod});
  @override
  List<Object> get props => [email,passwod];
}

class SignOutBtnPressed extends SignInEvent{}
