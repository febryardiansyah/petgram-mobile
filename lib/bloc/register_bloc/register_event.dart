part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
  @override
  List<Object> get props => [];
}

class RegisterBtnPressed extends RegisterEvent{
  final String name,email,password,petname;

  RegisterBtnPressed({this.name, this.email, this.password, this.petname});
  @override
  List<Object> get props => [name,email,password,petname];
}
