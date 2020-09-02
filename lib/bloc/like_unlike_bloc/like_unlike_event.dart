part of 'like_unlike_bloc.dart';

abstract class LikeUnlikeEvent extends Equatable {
  const LikeUnlikeEvent();
  @override
  List<Object> get props => [];
}

class LikeEvent extends LikeUnlikeEvent{
  final String id;

  LikeEvent({this.id});
  @override
  List<Object> get props => [id];
}

class UnlikeEvent extends LikeUnlikeEvent{
  final String id;

  UnlikeEvent({this.id});
  @override
  List<Object> get props => [id];
}