part of 'detail_post_bloc.dart';

abstract class DetailPostState extends Equatable {
  const DetailPostState();

  @override
  List<Object> get props => [];
}

class DetailPostInitial extends DetailPostState {}

class DetailPostLoading extends DetailPostState {}

class DetailPostLoaded extends DetailPostState {
  final DetailPostModel detailPost;

  DetailPostLoaded({this.detailPost});
  DetailPostLoaded copyWIth({DetailPostModel detailPost}){
    return DetailPostLoaded(
      detailPost: detailPost ?? this.detailPost,
    );
  }

  @override
  List<Object> get props => [detailPost];
}

class DetailPostFailure extends DetailPostState {
  final String msg;

  DetailPostFailure({this.msg});

  @override
  List<Object> get props => [msg];
}
