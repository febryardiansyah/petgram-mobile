part of 'post_comment_bloc.dart';

abstract class PostCommentState extends Equatable {
  const PostCommentState();
  @override
  List<Object> get props => [];
}

class PostCommentInitial extends PostCommentState {}
class PostCommentLoading extends PostCommentState {}
class PostCommentSuccess extends PostCommentState {}
class DeleteCommentSuccess extends PostCommentState {}
class DeleteCommentFailure extends PostCommentState {
  final String msg;

  DeleteCommentFailure({this.msg});
}
class PostCommentFailure extends PostCommentState {
  final String msg;

  PostCommentFailure({this.msg});
}
