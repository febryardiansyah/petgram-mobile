import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/following_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'following_post_event.dart';
part 'following_post_state.dart';

class FollowingPostBloc extends Bloc<FollowingPostEvent, FollowingPostState> {
  final POST _post;
  FollowingPostBloc(POST post) :this._post = post, super(FollowingPostInitial());

  @override
  Stream<FollowingPostState> mapEventToState(
    FollowingPostEvent event,
  ) async* {
    final currentState = state;
    if(event is FetchFollowingPost){
      if(currentState is FollowingPostLoaded){
        yield FollowingPostLoaded(data: currentState.data);
      }else{
        try{
          yield FollowingPostLoading();
          final response = await _post.getFollowingPost();
          if(response.message == 'success'){
            yield FollowingPostLoaded(data: response);
          }else{
            yield FollowingPostFailure(msg: response.message);
        }
        }catch(e){
          yield FollowingPostFailure(msg: e.toString());
        }
      }
    }
  }
}
