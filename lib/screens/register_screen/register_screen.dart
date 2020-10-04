import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petgram_mobile_app/bloc/register_bloc/register_bloc.dart';
import 'package:petgram_mobile_app/components/confirm_button.dart';
import 'package:petgram_mobile_app/components/loading_dialog.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/screens/register_screen/register_success_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isShowPassword = false;
  RegisterBloc _registerBloc;
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _petname = TextEditingController();
  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      body: BlocListener<RegisterBloc,RegisterState>(
        listener: (context,state){
          if(state is RegisterLoading){
            LoadingDialog(context: context,msg: 'Registering..');
          }
          if(state is RegisterSuccess){
            Navigator.pop(context);
            Navigator.pushNamed(context, '/registerSuccess',arguments: state.msg);
          }
          if(state is RegisterFailure){
            Navigator.pop(context);
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Failed Register',
              desc: state.msg,
              btnCancelOnPress: () {},
            )..show();
          }
        },
        child:Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(BaseString.wp1), fit: BoxFit.cover)),
            ),
            Positioned(
              top: 20,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,color: BaseColor.white,),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Text('Create new account',style: TextStyle(color: BaseColor.white,fontSize: 20),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 70,left: 10,right: 10),
              child: ListView(
                children: [
                  SizedBox(height: 20,),
                  MyFormField(
                    textEditingController: _name,
                    prefixIcon: Icon(Icons.person),
                    hintText: 'enter your name..',
                  ),
                  SizedBox(height: 20,),
                  MyFormField(
                    textEditingController: _email,
                    prefixIcon: Icon(Icons.email),
                    hintText: 'enter your email..',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20,),
                  MyFormField(
                    textEditingController: _password,
                    keyboardType: TextInputType.text,
                    hintText: 'enter your password',
                    prefixIcon: Icon(FontAwesomeIcons.key),
                    onFieldSubmitted: (value) {
                      print(value);
                    },
                    obscureText: _isShowPassword ? false : true,
                    suffixIcon: IconButton(
                      icon: Icon(!_isShowPassword
                          ? Icons.lock_outline
                          : Icons.lock_open),
                      onPressed: () {
                        setState(() {
                          if (!_isShowPassword) {
                            _isShowPassword = true;
                          } else {
                            _isShowPassword = false;
                          }
                        });
                      },
                    ),
                  ),
                  SizedBox(height: 20,),
                  MyFormField(
                    textEditingController: _petname,
                    prefixIcon: Icon(FontAwesomeIcons.cat),
                    hintText: 'enter your pet name..',
                  ),
                  SizedBox(height: 20,),
                  ConfirmButton(
                    onTap: (){
                      _registerBloc.add(RegisterBtnPressed(
                        name: _name.text,email: _email.text,password: _password.text,
                        petname: _petname.text
                      ));
                    },
                    height: 130.w,
                    width: size.width,
                    text: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(
                            color: BaseColor.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
