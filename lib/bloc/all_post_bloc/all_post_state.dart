part of 'all_post_bloc.dart';

abstract class AllPostState extends Equatable {
  const AllPostState();
  @override
  List<Object> get props => [];
}

class AllPostInitial extends AllPostState {}
class AllPostLoading extends AllPostState {}
class AllPostLoaded extends AllPostState {
  final AllPostModel allPostModel;

  AllPostLoaded({this.allPostModel});
  @override
  List<Object> get props => [allPostModel];
}
class AllPostFailure extends AllPostState{
  final String msg;

  AllPostFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
