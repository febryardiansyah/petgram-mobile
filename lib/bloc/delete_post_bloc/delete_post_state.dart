part of 'delete_post_bloc.dart';

abstract class DeletePostState extends Equatable {
  const DeletePostState();
  @override
  List<Object> get props => [];
}

class DeletePostInitial extends DeletePostState {}
class DeletePostSuccess extends DeletePostState {}
class DeletePostFailure extends DeletePostState {
  final String msg;

  DeletePostFailure({this.msg});
}

