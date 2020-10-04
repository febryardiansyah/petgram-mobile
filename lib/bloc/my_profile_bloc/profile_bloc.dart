import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/user_models/user_profile_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  final POST _post;
  MyProfileBloc(POST post) :this._post = post, super(MyProfileInitial());

  @override
  Stream<MyProfileState> mapEventToState(
    MyProfileEvent event,
  ) async* {
    final currentState = state;

    if(currentState is MyProfileFailure){
      yield MyProfileInitial();
    }
    if(event is FetchMyProfile){
      yield MyProfileLoading();
      try{
          final response = await _post.getMyProfile();

          if(response.status){
            yield MyProfileLoaded(userProfileModel: response);
          }else{
            yield MyProfileFailure(msg: response.message);
          }
        }catch(e){
          yield MyProfileFailure(msg: e.toString());
        }
    }

    if(event is ResetProfileEvent){
      yield MyProfileInitial();
    }

//    if(event is FetchUserProfile){
//        try{
//          yield ProfileLoading();
//
//          final response = await _post.getUserProfile(event.id);
//
//          if(response.status == true){
//            yield UserProfileLoaded(userProfileModel: response);
//          }else{
//            yield ProfileFailure(msg: response.message);
//          }
//        }catch(e){
//          yield ProfileFailure(msg: e.toString());
//        }
//
//    }
  }
}
