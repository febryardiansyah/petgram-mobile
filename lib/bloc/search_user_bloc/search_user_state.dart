part of 'search_user_bloc.dart';

abstract class SearchUserState extends Equatable {
  const SearchUserState();
  @override
  List<Object> get props => [];
}

class SearchUserInitial extends SearchUserState {}
class SearchUserLoading extends SearchUserState {}
class SearchUserLoaded extends SearchUserState {
  final SearchUserModel searchUserModel;

  const SearchUserLoaded({this.searchUserModel});

  @override
  List<Object> get props => [searchUserModel];
}
class SearchUserFailure extends SearchUserState {
  final String msg;

  const SearchUserFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

