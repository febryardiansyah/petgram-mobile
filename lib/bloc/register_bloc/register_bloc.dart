import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/auth_repo.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Auth _auth;

  RegisterBloc(Auth auth)
      : this._auth = auth,
        super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    final currentState = state;
    if (event is RegisterBtnPressed) {
      yield RegisterLoading();
      if(currentState is RegisterFailure || state is RegisterSuccess){
        yield RegisterInitial();
      }
      try {
        final Response response = await _auth.register(
            name: event.name,
            email: event.email,
            password: event.password,
            petname: event.petname);
        final bool status = response.data['status'];
        final String msg = response.data['message'];
        if (status) {
          yield RegisterSuccess(msg: msg);
        } else {
          yield RegisterFailure(msg: msg);
        }
      } catch (e) {
        yield RegisterFailure(msg: e.toString());
      }
    }
    if(currentState is RegisterSuccess){
      yield RegisterInitial();
    }
  }
}
