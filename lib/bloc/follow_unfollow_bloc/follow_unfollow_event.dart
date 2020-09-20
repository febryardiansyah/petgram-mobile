part of 'follow_unfollow_bloc.dart';

abstract class FollowUnfollowEvent extends Equatable {
  const FollowUnfollowEvent();
  @override
  List<Object> get props => [];
}

class FollowUser extends FollowUnfollowEvent{
  final String id;

  FollowUser({this.id});
}
class UnFollowUser extends FollowUnfollowEvent{
  final String id;

  UnFollowUser({this.id});
}
