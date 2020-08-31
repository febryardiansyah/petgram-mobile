part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}
class ProfileLoading extends ProfileState{}
class MyProfileLoaded extends ProfileState{
  final UserProfileModel userProfileModel;

  MyProfileLoaded({this.userProfileModel});
  @override
  List<Object> get props => [userProfileModel];
}
class ProfileFailure extends ProfileState{
  final msg;

  ProfileFailure({this.msg});
  @override
  List<Object> get props => [msg];
}
