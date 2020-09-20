import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'edit_post_event.dart';
part 'edit_post_state.dart';

class EditPostBloc extends Bloc<EditPostEvent, EditPostState> {
  POST _post;
  EditPostBloc(POST post) :this._post = post, super(EditPostInitial());

  @override
  Stream<EditPostState> mapEventToState(
    EditPostEvent event,
  ) async* {
    if(event is EditPost){
     yield EditPostLoading();
     try{
       final bool status = await _post.editPost(id: event.id,caption: event.caption);
       if(status){
         yield EditPostSuccess();
       }else{
         yield EditPostFailure(msg: 'Check your internet connection');
       }
     }catch(e){
       yield EditPostFailure(msg: e.toString());
     }
    }
  }
}
