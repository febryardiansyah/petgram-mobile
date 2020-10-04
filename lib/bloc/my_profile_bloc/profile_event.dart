part of 'profile_bloc.dart';

abstract class MyProfileEvent extends Equatable {
  const MyProfileEvent();
  @override
  List<Object> get props => [];
}
class FetchMyProfile extends MyProfileEvent{}
class ResetProfileEvent extends MyProfileEvent{}
