part of 'create_post_bloc.dart';

abstract class CreatePostState extends Equatable {
  const CreatePostState();
  @override
  List<Object> get props => [];
}

class CreatePostInitial extends CreatePostState {}
class CreatePostLoading extends CreatePostState {}
class CreatePostSuccess extends CreatePostState {}
class CreatePostFailure extends CreatePostState {
  final String msg;

  CreatePostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}

