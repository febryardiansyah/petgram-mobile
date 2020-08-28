part of 'following_post_bloc.dart';

abstract class FollowingPostState extends Equatable {
  const FollowingPostState();
  @override
  List<Object> get props => [];
}

class FollowingPostInitial extends FollowingPostState {}
class FollowingPostLoading extends FollowingPostState {}
class FollowingPostLoaded extends FollowingPostState {
  final FollowingPostModel data;

  FollowingPostLoaded({this.data});
  @override
  List<Object> get props => [data];
}
class FollowingPostFailure extends FollowingPostState {
  final String msg;

  FollowingPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
