import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/models/user_models/search_user_model.dart';
import 'package:petgram_mobile_app/repositories/user_repo.dart';

part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final USER _user;
  SearchUserBloc(USER user) :this._user = user, super(SearchUserInitial());

  @override
  Stream<SearchUserState> mapEventToState(
    SearchUserEvent event,
  ) async* {
    if(event is FetchSearchUser){
      yield SearchUserLoading();
      try{
        final SearchUserModel user = await _user.searchUser(query: event.query);
        final bool status = user.status;
        if(status){
          yield SearchUserLoaded(searchUserModel: user);
        }else{
          yield SearchUserFailure(msg: user.message);
        }
      }catch(e){
        yield SearchUserFailure(msg: e.toString());
      }
    }
  }
}
