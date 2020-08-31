import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:petgram_mobile_app/helpers/shared_preferences/profile_pref.dart';
import 'package:petgram_mobile_app/repositories/auth_repo.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final Auth _auth;
  final AuthBloc _authBloc;

  SignInBloc(Auth auth, AuthBloc authBloc)
      : this._auth = auth,
        this._authBloc = authBloc,
        assert(authBloc != null),
        super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    final currentState = state;
    if (event is SignInBtnPressed) {
      yield SignInLoading();
      if (currentState is SignInFailure) {
        yield SignInInitial();
      }
      try {
        final Response response =
            await _auth.signIn(email: event.email, password: event.passwod);
        final String message = response.data['message'].toString();
        final String token = response.data['token'].toString();

        if (response.data['status'] == true) {
          ProfilePreference.setProfile(response.data['user']['profilePic']);
          _authBloc.add(LoggedIn(token: token));
          yield SignInSuccess(msg: message);
        } else {
          yield SignInFailure(msg: message);
        }
      } catch (e) {
        yield SignInFailure(msg: e.toString());
      }
    }
    if (event is SignOutBtnPressed) {
      _authBloc.add(LoggedOut());
      yield SignInInitial();
    }
  }
}
