part of 'following_post_bloc.dart';

abstract class FollowingPostEvent extends Equatable {
  const FollowingPostEvent();
  @override
  List<Object> get props => [];
}
class FetchFollowingPost extends FollowingPostEvent{}
class UpdateFollowingPost extends FollowingPostEvent{
  final int like;
  final bool isLiked;

  UpdateFollowingPost({this.like, this.isLiked});
}
class ResetFollowingPostEvent extends FollowingPostEvent{}