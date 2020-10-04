part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();

}

class FetchUserProfile extends UserProfileEvent{
  final String id;

  FetchUserProfile({this.id});

  @override
  List<Object> get props => [];
}