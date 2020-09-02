import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/components/confirm_button.dart';
import 'package:petgram_mobile_app/components/my_form_field.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/helpers/font_size.dart';
import 'package:petgram_mobile_app/screens/home_screen/my_navigation_rail.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isShowPassword = false;
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<SignInBloc>(context);
  }

  @override
  Widget build(BuildContext context) {

    ScreenUtil.init(context);
    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();
    final timeNow = DateFormat('hh:mm').format(now);
    final parseTime = int.parse(DateFormat('kk').format(now));

    return Scaffold(
      body: BlocConsumer<SignInBloc,SignInState>(
        listener: (context,state){
          if(state is SignInLoading){
            AwesomeDialog(
                context: context,
                dialogType: DialogType.NO_HEADER,
                animType: AnimType.BOTTOMSLIDE,
                title: 'Loading',
                desc: 'Wait a sec..',
            )..show();
//            Scaffold.of(context)..hideCurrentSnackBar()
//              ..showSnackBar(SnackBar(content: Text('Loading...'),));
          }
          if(state is SignInSuccess){
            Scaffold.of(context)..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.msg,style: TextStyle(color: BaseColor.white),),backgroundColor: BaseColor.purple1,));
          }
          if(state is SignInFailure){
            AwesomeDialog(
              context: context,
              dialogType: DialogType.ERROR,
              animType: AnimType.BOTTOMSLIDE,
              title: 'Failed Login',
              desc: state.msg,
              btnCancelOnPress: () {},
            )..show();
          }
        },
        builder:(context,state) {
          if(state is SignInSuccess){
            return MyNavigationRail();
          }
          return Stack(
          children: [
            Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(BaseString.wp1), fit: BoxFit.cover)),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: ListView(
                  children: [
                    Text(
                      _greetings(parseTime),
                      style: TextStyle(
                          color: BaseColor.white, fontSize: setFontSize(100)),
                    ),
                    Text("it's $timeNow",
                        style: TextStyle(
                            color: BaseColor.white, fontSize: setFontSize(100))),
                    SizedBox(
                      height: 180.h,
                    ),
                    Text(
                      'Sign in to your account',
                      style: TextStyle(
                          color: BaseColor.white, fontSize: setFontSize(60)),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    MyFormField(
                      textEditingController: _email,
                      keyboardType: TextInputType.emailAddress,
                      hintText: 'enter your email address..',
                      prefixIcon: Icon(Icons.mail),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
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
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: RichText(
                            text: TextSpan(
                                text: "Don't have an account ? ",
                                style: TextStyle(color: BaseColor.grey3),
                                children: [
                                  TextSpan(
                                      text: 'Create',
                                      style: TextStyle(color: BaseColor.black))
                                ]),
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, '/registerScreen');
                          },
                        ),
                        Spacer(),
                        Text('Forgot Password'),
                      ],
                    ),
                    SizedBox(
                      height: 100.h,
                    ),
                    ConfirmButton(
                      onTap: () {
                        context.bloc<SignInBloc>().add(SignInBtnPressed(
                          email: _email.text,
                          passwod: _password.text,
                        ));
                      },
                      height: 130.w,
                      width: size.width,
                      text: Center(
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: BaseColor.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 450.h,
                    ),
                    Center(
                      child: Text('Petgram',style: TextStyle(fontFamily: BaseString.fBillabong,fontSize: setFontSize(100),color: BaseColor.white),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
        },
      ),
    );
  }

  String _greetings(int time){
    if(time <= 12 ){
      return 'Good Morning,';
    }else if ((time > 12) && (time <= 16)) {
      return 'Good Afternoon,';
    }else if ((time > 16) && (time <= 20)) {
      return 'Good Evening,';
    }else{
      return 'Good Night,';
    }
  }
}
