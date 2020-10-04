import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';

import '../edit_profile_form_screen.dart';

class PetNameFormScreen extends StatelessWidget {
  final String petname;

  PetNameFormScreen({this.petname});

  TextEditingController _petCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _petCtrl = TextEditingController(text: this.petname);
    return BlocListener<EditProfileBloc,EditProfileState>(
      listener: (context,state){
        if(state is EditProfileSuccess){
          context.bloc<MyProfileBloc>().add(FetchMyProfile());
          Navigator.pop(context);
        }
      },
      child: EditProfileFormScreen(
        onDone: (){
          context.bloc<EditProfileBloc>().add(EditPetNameProfileEvent(petname: _petCtrl.text));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyFormField(
            autoFocus: true,
            textEditingController: _petCtrl,
            hintText: 'your petname..',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
