import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/user_repo.dart';

part 'follow_unfollow_event.dart';
part 'follow_unfollow_state.dart';

class FollowUnfollowUserBloc extends Bloc<FollowUnfollowEvent, FollowUnfollowState> {
  final USER _user;
  FollowUnfollowUserBloc(USER user) :this._user = user, super(FollowUnfollowInitial());

  @override
  Stream<FollowUnfollowState> mapEventToState(
    FollowUnfollowEvent event,
  ) async* {
    if(event is FollowUser){
      yield FollowUnfollowLoading();
      try{
        final bool status = await _user.followUser(event.id);
        if(status){
          yield FollowUserSuccess();
        }else{
          yield FollowUserFailure(msg: 'something wrong !!');
        }
      }catch(e){
        yield FollowUserFailure(msg: e.toString());
      }
    }
    if(event is UnFollowUser){
      yield FollowUnfollowLoading();
      try{
        final bool status = await _user.unFollowUser(event.id);
        if(status){
          yield UnFollowUserSuccess();
        }else{
          yield UnFollowUserFailure(msg: 'something wrong !!');
        }
      }catch(e){
        yield UnFollowUserFailure(msg: e.toString());
      }
    }
  }
}
