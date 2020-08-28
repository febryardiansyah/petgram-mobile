part of 'following_post_bloc.dart';

abstract class FollowingPostEvent extends Equatable {
  const FollowingPostEvent();
  @override
  List<Object> get props => [];
}
class FetchFollowingPost extends FollowingPostEvent{}