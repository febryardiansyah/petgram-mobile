part of 'create_post_bloc.dart';

abstract class CreatePostEvent extends Equatable {
  const CreatePostEvent();
  @override
  List<Object> get props => [];
}

class CreatePost extends CreatePostEvent{
  final File image;
  final String caption;

  CreatePost({this.image, this.caption});

  @override
  List<Object> get props => [image,caption];
}
class ResetCreatePostEvent extends CreatePostEvent{}