part of 'post_comment_bloc.dart';

abstract class PostCommentState extends Equatable {
  const PostCommentState();
  @override
  List<Object> get props => [];
}

class PostCommentInitial extends PostCommentState {}
class PostCommentSuccess extends PostCommentState {}
class PostCommentFailure extends PostCommentState {
  final String msg;

  PostCommentFailure({this.msg});
}
