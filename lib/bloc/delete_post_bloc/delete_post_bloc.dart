import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'delete_post_event.dart';
part 'delete_post_state.dart';

class DeletePostBloc extends Bloc<DeletePostEvent, DeletePostState> {
  final POST _post;
  DeletePostBloc(POST post) :this._post = post, super(DeletePostInitial());

  @override
  Stream<DeletePostState> mapEventToState(
    DeletePostEvent event,
  ) async* {
    if(event is DeletePost){
      try{
        final bool status = await _post.deletePost(event.id);
        if(status){
          yield DeletePostSuccess();
        }else{
          yield DeletePostFailure(msg: 'delete post failure');
        }
      }catch(e){
        yield DeletePostFailure(msg: e.toString());
      }
    }

  }
}
