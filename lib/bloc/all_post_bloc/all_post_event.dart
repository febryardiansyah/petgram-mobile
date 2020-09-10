part of 'all_post_bloc.dart';

abstract class AllPostEvent extends Equatable {
  const AllPostEvent();
  @override
  List<Object> get props => [];
}
class FetchAllPostEvent extends AllPostEvent{}
