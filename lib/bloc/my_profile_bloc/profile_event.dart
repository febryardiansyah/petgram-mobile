part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}
class FetchMyProfile extends ProfileEvent{}
class FetchUserProfile extends ProfileEvent{
  final String id;

  FetchUserProfile({this.id});
  @override
  List<Object> get props => [id];
}
class ResetProfileEvent extends ProfileEvent{}
