part of 'following_post_bloc.dart';

abstract class FollowingPostState extends Equatable {
  const FollowingPostState();
  @override
  List<Object> get props => [];
}

class FollowingPostInitial extends FollowingPostState {}
class FollowingPostLoading extends FollowingPostState {}
class FollowingPostLoaded extends FollowingPostState {
  final List<PostModel> data;
  bool hasReachedMax;
  int page;

  FollowingPostLoaded({this.data,this.hasReachedMax,this.page});
  FollowingPostLoaded copyWith({List<PostModel> data, bool hasReachedMax}){
    return FollowingPostLoaded(
      data: data ?? this.data,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [data,hasReachedMax];
}
class FollowingPostFailure extends FollowingPostState {
  final String msg;

  FollowingPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
