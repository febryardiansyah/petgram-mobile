import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/screens/edit_profile_screen/edit_profile_form_screen.dart';

class NameFormScreen extends StatelessWidget {
  final String name;

  NameFormScreen({this.name});

  TextEditingController _nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _nameCtrl = TextEditingController(text: this.name);
    return BlocListener<EditProfileBloc,EditProfileState>(
      listener: (context,state){
        if(state is EditProfileSuccess){
          context.read<MyProfileBloc>().add(FetchMyProfile());
          Navigator.pop(context);
        }
      },
      child: EditProfileFormScreen(
        onDone: (){
          context.read<EditProfileBloc>().add(EditNameProfileEvent(name: _nameCtrl.text));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyFormField(
            autoFocus: true,
            textEditingController: _nameCtrl,
            hintText: 'your name..',
            prefixIcon: Icon(Icons.person),
          ),
        ),
      ),
    );
  }
}
