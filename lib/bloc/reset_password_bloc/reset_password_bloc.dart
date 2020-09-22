import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/user_repo.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final USER _user;
  ResetPasswordBloc(USER user) :this._user = user, super(ResetPasswordInitial());

  @override
  Stream<ResetPasswordState> mapEventToState(
    ResetPasswordEvent event,
  ) async* {
    if(event is DoResetPassword){
      yield ResetPasswordLoading();
      try{
        final bool status = await _user.resetPassword(email: event.email);
        if(status){
          yield ResetPasswordSuccess(msg: 'Reset password success, check your email !!');
        }else{
          yield ResetPasswordFailure(msg: 'Email is not valid');
        }
      }catch(e){
        yield ResetPasswordSuccess(msg: e.toString());
      }
    }
  }
}
