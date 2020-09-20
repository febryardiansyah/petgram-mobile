import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:petgram_mobile_app/repositories/user_repo.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  final USER _user;
  EditProfileBloc(USER user) :this._user = user, super(EditProfileInitial());

  @override
  Stream<EditProfileState> mapEventToState(
    EditProfileEvent event,
  ) async* {
    if(event is EditNameProfileEvent){
      yield EditProfileLoading();
      try{
        final bool status = await _user.editNameProfile(name: event.name);
        if(status){
          yield EditProfileSuccess();
        }else{
          yield EditProfileFailure(msg: 'Something wrong !!');
        }
      }catch(e){
        yield EditProfileFailure(msg: e.toString());
      }
    }
    if(event is EditPetNameProfileEvent){
      yield EditProfileLoading();
      try{
        final bool status = await _user.editPetNameProfile(petname: event.petname);
        if(status){
          yield EditProfileSuccess();
        }else{
          yield EditProfileFailure(msg: 'Something wrong !!');
        }
      }catch(e){
        yield EditProfileFailure(msg: e.toString());
      }
    }

    if(event is EditPasswordEvent){
      yield EditProfileLoading();
      try{
        final bool status = await _user.editPasswordProfile(password: event.password);
        if(status){
          yield EditProfileSuccess();
        }else{
          yield EditProfileFailure(msg: 'Something wrong !!');
        }
      }catch(e){
        yield EditProfileFailure(msg: e.toString());
      }
    }

    if(event is EditProfilePicEvent){
      yield EditProfileLoading();
      try{
        final bool status = await _user.editProfilePic(image: event.image);
        if(status){
          yield EditProfileSuccess();
        }else{
          yield EditProfileFailure(msg: 'Something wrong !!');
        }
      }catch(e){
        yield EditProfileFailure(msg: e.toString());
      }
    }
  }
}
