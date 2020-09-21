part of 'follow_unfollow_bloc.dart';

abstract class FollowUnfollowState extends Equatable {
  const FollowUnfollowState();
  @override
  List<Object> get props => [];
}

class FollowUnfollowInitial extends FollowUnfollowState {}
class FollowUnfollowLoading extends FollowUnfollowState {}
class FollowUserSuccess extends FollowUnfollowState {}
class UnFollowUserSuccess extends FollowUnfollowState {}
class FollowUserFailure extends FollowUnfollowState {
  final String msg;

  FollowUserFailure({this.msg});
}
class UnFollowUserFailure extends FollowUnfollowState {
  final String msg;

  UnFollowUserFailure({this.msg});
}
