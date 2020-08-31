import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/screens/profile_screen/ProfileScreen.dart';

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProfileBloc>(context)..add(FetchProfile());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc,ProfileState>(
        listener: (context,state){},
        builder: (context,state){
          print(state);
          if(state is ProfileFailure){
            return Text(state.msg);
          }
          if(state is MyProfileLoaded){
            final userDetail = state.userProfileModel.user.detailModel;
            final posts = state.userProfileModel.user.postModel;
            return ProfileScreen(
//              name: state.userProfileModel.user.detailModel.name,
//              profilePic: userDetail.profilePic,
//              petname: userDetail.petname,
            );
          }
          return Container();
        },
      ),
    );
  }
}

