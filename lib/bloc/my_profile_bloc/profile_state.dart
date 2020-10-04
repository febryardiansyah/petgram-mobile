part of 'profile_bloc.dart';

abstract class MyProfileState extends Equatable {
  const MyProfileState();
  @override
  List<Object> get props => [];
}

class MyProfileInitial extends MyProfileState {}
class MyProfileLoading extends MyProfileState{}
class MyProfileLoaded extends MyProfileState{
  final UserProfileModel userProfileModel;

  MyProfileLoaded({this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}

class MyProfileFailure extends MyProfileState{
  final msg;

  MyProfileFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
