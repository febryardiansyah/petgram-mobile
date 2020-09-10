import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'post_comment_event.dart';
part 'post_comment_state.dart';

class PostCommentBloc extends Bloc<PostCommentEvent, PostCommentState> {
  final POST _post;
  PostCommentBloc(POST post) :this._post = post, super(PostCommentInitial());

  @override
  Stream<PostCommentState> mapEventToState(
    PostCommentEvent event,
  ) async* {
    if(event is CommentEvent){
      try{
        final Response response = await _post.postComment(id: event.id,text: event.text);
        final bool status = response.data['status'];
        if(status){
          yield PostCommentSuccess();
        }else{
          yield PostCommentFailure(msg: response.data['message']);
        }
      }catch(e){
        yield PostCommentFailure(msg: e.toString());
      }
    }

  }
}
