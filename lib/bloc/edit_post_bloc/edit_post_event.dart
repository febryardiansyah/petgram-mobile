part of 'edit_post_bloc.dart';

abstract class EditPostEvent extends Equatable {
  const EditPostEvent();
  @override
  List<Object> get props => [];
}

class EditPost extends EditPostEvent {
  final String id;
  final String caption;

  EditPost({this.id, this.caption});
  @override
  List<Object> get props => [id,caption];
}