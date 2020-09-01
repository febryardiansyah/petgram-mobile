import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/index.dart';
import 'package:petgram_mobile_app/screens/detail_post_screen/detail_post_screen.dart';
import 'package:petgram_mobile_app/screens/login_screen/login_screen.dart';
import 'package:petgram_mobile_app/screens/profile_screen/my_profile_screen.dart';
import 'package:petgram_mobile_app/screens/profile_screen/user_profile_screen.dart';
import 'package:petgram_mobile_app/screens/register_screen/register_screen.dart';
import 'package:petgram_mobile_app/screens/splash_screen.dart';

MaterialPageRoute _pageRoute({Widget builder,RouteSettings settings,bool isFullScreen = false})=>
    MaterialPageRoute(builder: (_) => builder,settings: settings,fullscreenDialog: isFullScreen);

Route generateRoute(RouteSettings settings){
  final args = settings.arguments;
  switch(settings.name){
    case '/':
      return _pageRoute(builder: SplashScreen(),settings: settings);
    case '/index':
      return _pageRoute(builder: Index(),settings: settings);
    case '/loginScreen':
      return _pageRoute(builder: LoginScreen(),settings: settings);
    case '/registerScreen':
      return _pageRoute(builder: RegisterScreen(),settings: settings);
    case '/detailPost':
      return _pageRoute(builder: DetailPostScreen(postModel: args,),settings: settings);
    case '/myProfile':
      return _pageRoute(builder: MyProfileScreen(),settings: settings);
    case '/userProfile':
      return _pageRoute(builder: UserProfileScreen(id: args),settings: settings,);
  }
}