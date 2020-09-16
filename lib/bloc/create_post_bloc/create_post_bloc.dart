import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'create_post_event.dart';
part 'create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  POST _post;
  CreatePostBloc(POST post) :this._post = post, super(CreatePostInitial());

  @override
  Stream<CreatePostState> mapEventToState(
    CreatePostEvent event,
  ) async* {
    if(event is CreatePost){
      yield CreatePostLoading();
      try{
        final Response response = await _post.createPost(image: event.image,caption: event.caption);
        final bool status = response.data['status'];
        final String msg = response.data['error']['message'] ?? response.data['error'] ;

        if(status){
          yield CreatePostSuccess();
        }else{
          yield CreatePostFailure(msg: msg);
        }
      }catch(e){
        yield CreatePostFailure(msg: e.toString());
      }
    }
    if(event is ResetCreatePostEvent){
      yield CreatePostInitial();
    }
  }
}
