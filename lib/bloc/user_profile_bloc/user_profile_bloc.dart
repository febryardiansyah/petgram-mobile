import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/user_models/user_profile_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final POST _post;
  UserProfileBloc(this._post) : super(UserProfileInitial());

  @override
  Stream<UserProfileState> mapEventToState(
    UserProfileEvent event,
  ) async* {
    if(event is FetchUserProfile){
      yield UserProfileLoading();
      try{
        final UserProfileModel response = await _post.getUserProfile(event.id);
        if(response.status){
          yield UserProfileLoaded(userProfileModel: response);
        }else{
          yield UserProfileFailure(msg: response.message);
        }
      }catch(e){
        yield UserProfileFailure(msg: e.toString());
      }
    }
  }
}
