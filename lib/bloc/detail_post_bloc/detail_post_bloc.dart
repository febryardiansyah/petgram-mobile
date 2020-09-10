import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/post_models/detail_post_model.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';

part 'detail_post_event.dart';

part 'detail_post_state.dart';

class DetailPostBloc extends Bloc<DetailPostEvent, DetailPostState> {
  final POST _post;

  DetailPostBloc(POST post)
      : this._post = post,
        super(DetailPostInitial());

  @override
  Stream<DetailPostState> mapEventToState(
    DetailPostEvent event,
  ) async* {

    final currentState = state;

    if (event is FetchDetailPost) {
      yield DetailPostLoading();
      try {
        final DetailPostModel response =
            await _post.getDetailPost(id: event.id);
        if (response.status) {
          yield DetailPostLoaded(detailPost: response);
        } else {
          yield DetailPostFailure(msg: response.message);
        }
      } catch (e) {
        yield DetailPostFailure(msg: e.toString());
      }
    }
    if(event is UpdateDetailPost){
      if(currentState is DetailPostLoaded){
        try {
          final DetailPostModel response =
          await _post.getDetailPost(id: event.id);
          if (response.status) {
            yield currentState.copyWIth(detailPost: response);
          } else {
            yield DetailPostFailure(msg: response.message);
          }
        } catch (e) {
          yield DetailPostFailure(msg: e.toString());
        }
      }

    }
  }
}
