import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/all_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'all_post_event.dart';
part 'all_post_state.dart';

class AllPostBloc extends Bloc<AllPostEvent, AllPostState> {
  final POST _post;
  AllPostBloc(POST post) :this._post=post, super(AllPostInitial());

  @override
  Stream<AllPostState> mapEventToState(
    AllPostEvent event,
  ) async* {
    final currentState = state;
    if(event is FetchAllPostEvent){
      if(currentState is AllPostFailure){
        yield AllPostInitial();
      }
      yield AllPostLoading();
      try{
        final AllPostModel response = await _post.getAllPost();
        if(response.status == true){
          yield AllPostLoaded(allPostModel: response);
        }else{
          yield AllPostFailure(msg: response.message);
        }
      }catch(e){
        yield AllPostFailure(msg: e.toString());
      }
    }
  }
}
