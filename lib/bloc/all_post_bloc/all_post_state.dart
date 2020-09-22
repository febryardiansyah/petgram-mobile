part of 'all_post_bloc.dart';

abstract class AllPostState extends Equatable {
  const AllPostState();
  @override
  List<Object> get props => [];
}

class AllPostInitial extends AllPostState {}
class AllPostLoading extends AllPostState {}
class AllPostLoaded extends AllPostState {
  final List<PostModel> allPost;
  bool hasReachedMax;
  int page = 0;

  AllPostLoaded({this.hasReachedMax,this.page,this.allPost});

  AllPostLoaded copyWith({bool hasReachedMax,List<PostModel> allPost}){
    return AllPostLoaded(
      allPost: allPost ?? this.allPost,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax
    );
  }
  @override
  List<Object> get props => [allPost,hasReachedMax,page];
}
class AllPostFailure extends AllPostState{
  final String msg;

  AllPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
