import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/post_models/all_post_model.dart';
import 'package:petgram_mobile_app/models/post_models/following_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';
import 'package:rxdart/rxdart.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final POST _post;
  AllPostBloc(POST post) :this._post=post, super(AllPostInitial());

  bool hasReachedMax (AllPostState state) => state is AllPostLoaded && state.hasReachedMax;

  @override
  Stream<Transition<AllPostEvent, AllPostState>> transformEvents(Stream<AllPostEvent> events, transitionFn) {
    return super.transformEvents(events.debounceTime(Duration(milliseconds: 500)), transitionFn);
  }

  @override
  Stream<AllPostState> mapEventToState(
    AllPostEvent event,
  ) async* {
    final currentState = state;
    int page = 0;
    if(event is FetchAllPostEvent && !hasReachedMax(currentState)){
      if(currentState is AllPostInitial){
        yield AllPostLoading();
        try{
          final AllPostModel response = await _post.getAllPost(page: page);
          if(response.status == true){
            yield AllPostLoaded(allPost: response.allPost,page: page+1,hasReachedMax: false);
          }else{
            yield AllPostFailure(msg: response.message);
          }
        }catch(e){
          print(e.toString());
          yield AllPostFailure(msg: e.toString());
        }
      }
      if(currentState is AllPostLoaded){
        try{
          final AllPostModel response = await _post.getAllPost(page: currentState.page);
          if(response.status == true){
            yield response.allPost.isEmpty ?currentState.copyWith(hasReachedMax: true,allPost: currentState.allPost)
            :AllPostLoaded(allPost: currentState.allPost + response.allPost,page: currentState.page+1,hasReachedMax: false);
          }else{
            yield AllPostFailure(msg: response.message);
          }
        }catch(e){
          yield AllPostFailure(msg: e.toString());
        }
      }

    }
    if(event is UpdateAllPost){
      if(currentState is AllPostLoaded){
        try{
          final AllPostModel response = await _post.getAllPost();
          yield AllPostLoaded(allPost: response.allPost,hasReachedMax: false,page: page+1);
        }catch(e){
          yield AllPostFailure(msg: e.toString());
        }
      }
    }
  }
}
