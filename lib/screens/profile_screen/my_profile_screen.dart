import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shimmer/flutter_shimmer.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/screens/profile_screen/ProfileScreen.dart';
import 'package:petgram_mobile_app/screens/profile_screen/profile_loading.dart';

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
  void didUpdateWidget(MyProfileScreen oldWidget) {
    print(oldWidget);
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc,ProfileState>(
        listener: (context,state){
          if(state is ProfileFailure){
            Scaffold.of(context)..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text(state.msg),
                ));
          }
        },
        builder: (context,state){
          print(state);
          if(state is ProfileLoading){
            return ProfileScreenLoading();
          }
          if(state is ProfileFailure){
            return Center(
              child: Text(state.msg),
            );
          }
          if(state is MyProfileLoaded){
            return ProfileScreen(
              userDetail: state.userProfileModel.user,
            );
          }
          return Container();
        },
      ),
    );
  }
}

