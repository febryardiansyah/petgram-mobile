import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';

import '../edit_profile_form_screen.dart';

class EditPasswordFormScreen extends StatefulWidget {

  @override
  _EditPasswordFormScreenState createState() => _EditPasswordFormScreenState();
}

class _EditPasswordFormScreenState extends State<EditPasswordFormScreen> {
  TextEditingController _passCtrl = TextEditingController();

  bool _isShowPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileBloc,EditProfileState>(
      listener: (context,state){
        if(state is EditProfileSuccess){
          context.read<MyProfileBloc>().add(FetchMyProfile());
          Navigator.pop(context);
        }
      },
      child: EditProfileFormScreen(
        onDone: (){
          context.read<EditProfileBloc>().add(EditPasswordEvent(password: _passCtrl.text));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyFormField(
            obscureText: _isShowPassword ? false : true,
            textEditingController: _passCtrl,
            hintText: 'your new password..',
            prefixIcon: Icon(FontAwesomeIcons.key),
            suffixIcon: IconButton(
              icon: Icon(_isShowPassword
                  ? Icons.lock_open
                  : Icons.lock_outline),
              onPressed: () {
                if (_isShowPassword) {
                  setState(() {
                    _isShowPassword = false;
                  });
                } else {
                  setState(() {
                    _isShowPassword = true;
                  });
                }
              },
            ),
          ),
        ),
        ),
      );
  }
}
