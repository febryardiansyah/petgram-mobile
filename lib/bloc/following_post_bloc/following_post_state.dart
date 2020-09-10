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
  bool isLiked;

  FollowingPostLoaded({this.data,this.isLiked});
  FollowingPostLoaded copyWith({FollowingPostModel data, bool isLiked}){
    return FollowingPostLoaded(
      data: this.data ?? data,
      isLiked: this.isLiked ?? isLiked,
    );
  }

  @override
  List<Object> get props => [data,isLiked];
}
class FollowingPostFailure extends FollowingPostState {
  final String msg;

  FollowingPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
