part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeState extends Equatable {
  const LikeUnlikeState();
  @override
  List<Object> get props => [];
}

class LikeUnlikeInitial extends LikeUnlikeState {}
class LikeSuccess extends LikeUnlikeState{
  final LikeUnlikeModel likeModel;

  LikeSuccess({this.likeModel});
  @override
  List<Object> get props => [likeModel];
}
class UnlikeSuccess extends LikeUnlikeState{}
class LikeFailure extends LikeUnlikeState{
  final String msg;

  LikeFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
class UnlikeFailure extends LikeUnlikeState{
  final String msg;

  UnlikeFailure({this.msg});

  @override
  List<Object> get props => [msg];
}
