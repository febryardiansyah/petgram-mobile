import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:petgram_mobile_app/screens/home_screen/my_navigation_rail.dart';
import 'package:petgram_mobile_app/screens/login_screen/login_screen.dart';
import 'package:petgram_mobile_app/screens/splash_screen.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc,AuthState>(
      builder: (context,state){
        print(state);
        if(state is Authenticated){
          return MyNavigationRail();
        }
        if(state is Unauthenticated){
          return LoginScreen();
        }
        return Container();
      },
    );
  }
}
