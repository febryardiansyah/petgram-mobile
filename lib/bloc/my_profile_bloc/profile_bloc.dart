import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/user_profile_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final POST _post;
  ProfileBloc(POST post) :this._post = post, super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    final currentState = state;
    if(event is FetchProfile){
      yield ProfileLoading();
      if(currentState is MyProfileLoaded){
        yield MyProfileLoaded(userProfileModel: currentState.userProfileModel);
      }
      try{
        final response = await _post.getMyProfile();
        if(response.status == true){
          yield MyProfileLoaded(userProfileModel: response);
        }else{
          yield ProfileFailure(msg: response.message);
        }
      }catch(e){
        yield ProfileFailure(msg: e.toString());
      }
    }
  }
}
