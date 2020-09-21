part of 'search_user_bloc.dart';

abstract class SearchUserEvent extends Equatable {
  const SearchUserEvent();
  @override
  List<Object> get props => [];
}

class FetchSearchUser extends SearchUserEvent{
  final String query;

  FetchSearchUser({this.query});
  @override
  List<Object> get props => [query];
}
