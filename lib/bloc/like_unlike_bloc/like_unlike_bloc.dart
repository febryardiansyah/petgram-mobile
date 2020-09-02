import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/like_unlike_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'like_unlike_event.dart';
part 'like_unlike_state.dart';

class LikeUnlikeBloc extends Bloc<LikeUnlikeEvent, LikeUnlikeState> {
  final POST _post;
  LikeUnlikeBloc(POST post) :this._post=post, super(LikeUnlikeInitial());

  @override
  Stream<LikeUnlikeState> mapEventToState(
    LikeUnlikeEvent event,
  ) async* {
    if (event is LikeEvent) {
      if(state is LikeFailure){
        yield LikeUnlikeInitial();
      }
      try{
        final LikeUnlikeModel response = await _post.likePost(event.id);

        if(response.status == true){
          yield LikeSuccess(likeModel: response);
        }else{
          yield LikeFailure(msg: response.message);
        }
      }catch(e){
        yield LikeFailure(msg: e.toString());
      }
    }
    if (event is UnlikeEvent) {
      if(state is UnlikeFailure){
        yield LikeUnlikeInitial();
      }
      try{
        final Response response = await _post.unlikePost(event.id);
        final bool status = response.data['status'];

        if(status == true){
          yield UnlikeSuccess();
        }else{
          yield UnlikeFailure(msg: response.data['message']);
        }
      }catch(e){
        yield UnlikeFailure(msg: e.toString());
      }
    }
  }
}
