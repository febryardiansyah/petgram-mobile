part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
  @override
  List<Object> get props => [];
}

class UserProfileInitial extends UserProfileState {}
class UserProfileLoading extends UserProfileState {}
class UserProfileLoaded extends UserProfileState {
  final UserProfileModel userProfileModel;

  UserProfileLoaded({this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}

class UserProfileFailure extends UserProfileState{
  final String msg;

  UserProfileFailure({this.msg});
}

