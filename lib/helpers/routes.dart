import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/index.dart';
import 'package:petgram_mobile_app/screens/browse_screen/search_user_screen.dart';
import 'package:petgram_mobile_app/screens/create_post_screen/create_post_screen.dart';
import 'package:petgram_mobile_app/screens/detail_post_screen/detail_post_screen.dart';
import 'package:petgram_mobile_app/screens/edit_post_screen/edit_post_screen.dart';
import 'package:petgram_mobile_app/screens/edit_profile_screen/edit_profile.dart';
import 'package:petgram_mobile_app/screens/home_screen/my_navigation_rail.dart';
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
    case '/home':
      return _pageRoute(builder: MyNavigationRail(),settings: settings);
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
    case '/createPost':
      return _pageRoute(builder: CreatePostScreen(),settings: settings);
    case '/editPost':
      return _pageRoute(builder: EditPostScreen(currentCaption: args,),settings: settings);
    case '/editProfile':
      return _pageRoute(builder: EditProfileScreen(userDetail: args,),settings: settings,);
    case '/search':
      return _pageRoute(builder: SearchUserScreen(),settings: settings,);
  }
}