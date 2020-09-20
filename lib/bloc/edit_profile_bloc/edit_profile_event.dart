part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  const EditProfileEvent();
  @override
  List<Object> get props => [];
}

class EditProfilePicEvent extends EditProfileEvent {
  final File image;

  EditProfilePicEvent({this.image});
}

class EditNameProfileEvent extends EditProfileEvent {
  final String name;

  EditNameProfileEvent({this.name});
}

class EditPetNameProfileEvent extends EditProfileEvent {
  final String petname;

  EditPetNameProfileEvent({this.petname});
}

class EditPasswordEvent extends EditProfileEvent{
  final String password;

  EditPasswordEvent({this.password});
}
