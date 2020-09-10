part of 'detail_post_bloc.dart';

abstract class DetailPostEvent extends Equatable {
  const DetailPostEvent();
  @override
  List<Object> get props => [];
}

class FetchDetailPost extends DetailPostEvent{
  final String id;

  FetchDetailPost({this.id});
  @override
  List<Object> get props => [id];
}

class UpdateDetailPost extends DetailPostEvent{
  final String id;

  UpdateDetailPost({this.id});

  @override
  List<Object> get props => [id];
}