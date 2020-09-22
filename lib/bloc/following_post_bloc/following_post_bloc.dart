import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';
import 'package:rxdart/rxdart.dart';

part 'following_post_event.dart';
part 'following_post_state.dart';

class FollowingPostBloc extends Bloc<FollowingPostEvent, FollowingPostState> {
  final POST _post;
  FollowingPostBloc(POST post) :this._post = post, super(FollowingPostInitial());
  
  bool _hasReachedMax(FollowingPostState state) => state is FollowingPostLoaded && state.hasReachedMax;

  @override
  Stream<Transition<FollowingPostEvent, FollowingPostState>> transformEvents(Stream<FollowingPostEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<FollowingPostState> mapEventToState(
    FollowingPostEvent event,
  ) async* {
    final currentState = state;
    int page = 0;
    if(event is FetchFollowingPost && !_hasReachedMax(currentState)){
      if(currentState is FollowingPostInitial){
        try{
          yield FollowingPostLoading();
          final response = await _post.getFollowingPost(page: page);

          if(response == null){
            yield FollowingPostLoaded(data: null);
          }else if(response.status){
            yield FollowingPostLoaded(data: response.postModel,hasReachedMax: false,page: page+1);
          }else{
            yield FollowingPostFailure(msg: response.message);
          }
        }catch(e){
          yield FollowingPostFailure(msg: e.toString());
        }
      }

      if(currentState is FollowingPostLoaded){
        try{
          final response = await _post.getFollowingPost(page: currentState.page);

          if(response.status){
            yield response.postModel.isEmpty ? currentState.copyWith(hasReachedMax: true,data: currentState.data)
                :FollowingPostLoaded(data: currentState.data + response.postModel,hasReachedMax: false,page: currentState.page+1);
          }else{
            yield FollowingPostFailure(msg: response.message);
          }
        }catch(e){
          yield FollowingPostFailure(msg: e.toString());
        }
      }
    }
    if(event is ResetFollowingPostEvent){
      yield FollowingPostInitial();
    }
    if(event is UpdateFollowingPost){
      if(currentState is FollowingPostLoaded){
        try{
          final response = await _post.getFollowingPost(page: page);
          if(response.status) {
            yield FollowingPostLoaded(data: response.postModel,hasReachedMax: false,page: page+1);
          }else{
            yield FollowingPostFailure(msg: 'No internet');
          }
        }catch(e){
          yield FollowingPostFailure(msg: 'No internet');
        }
      }
    }
  }
}
