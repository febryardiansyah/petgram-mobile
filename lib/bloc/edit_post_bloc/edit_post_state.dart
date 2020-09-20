part of 'edit_post_bloc.dart';

abstract class EditPostState extends Equatable {
  const EditPostState();
  @override
  List<Object> get props => [];
}

class EditPostInitial extends EditPostState {}
class EditPostLoading extends EditPostState {}
class EditPostSuccess extends EditPostState {}
class EditPostFailure extends EditPostState {
  final String msg;

  EditPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
