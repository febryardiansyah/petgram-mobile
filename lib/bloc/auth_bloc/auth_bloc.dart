import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/auth_repo.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Auth _auth;

  AuthBloc(Auth auth)
      : this._auth = auth,
        assert(auth != null),
        super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if(event is AppStarted){
      yield AuthLoading();
      try{
        final bool hasToken = await _auth.hasToken();
        if(hasToken){
          yield Authenticated();
        }else{
          yield Unauthenticated();
        }
      }catch(e){
        yield Unauthenticated();
      }
    }
    if(event is LoggedIn){
      yield AuthLoading();
      try{
        await _auth.persistToken(event.token);
        yield Authenticated();
      }catch(e){
        yield Unauthenticated();
      }
    }
    if(event is LoggedOut){
      await _auth.deleteToken();
      yield Unauthenticated();
    }
  }
}
