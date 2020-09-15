part of 'delete_post_bloc.dart';

abstract class DeletePostEvent extends Equatable {
  const DeletePostEvent();
  @override
  List<Object> get props => [];
}

class DeletePost extends DeletePostEvent{
  final String id;

  DeletePost({this.id});
  @override
  List<Object> get props => [id];
}