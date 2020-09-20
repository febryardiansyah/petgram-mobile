import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/all_post_bloc/all_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/create_post_bloc/create_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/delete_post_bloc/delete_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/detail_post_bloc/detail_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_post_bloc/edit_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/edit_profile_bloc/edit_profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/follow_unfollow_bloc/follow_unfollow_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/like_unlike_bloc/like_unlike_bloc.dart';
import 'package:petgram_mobile_app/bloc/my_profile_bloc/profile_bloc.dart';
import 'package:petgram_mobile_app/bloc/postComment_bloc/post_comment_bloc.dart';
import 'package:petgram_mobile_app/bloc/register_bloc/register_bloc.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/helpers/routes.dart';
import 'package:petgram_mobile_app/repositories/auth_repo.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';
import 'package:petgram_mobile_app/repositories/user_repo.dart';

import 'bloc/auth_bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(BlocProvider<AuthBloc>(
    create: (_) => AuthBloc(AuthRepository())..add(AppStarted()),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignInBloc>(
          create: (_) => SignInBloc(AuthRepository(),AuthBloc(AuthRepository())),
        ),
        BlocProvider<RegisterBloc>(
          create: (_) => RegisterBloc(AuthRepository()),
        ),
        BlocProvider<FollowingPostBloc>(
          create: (_) => FollowingPostBloc(PostRepo()),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => ProfileBloc(PostRepo()),
        ),
        BlocProvider<LikeUnlikeBloc>(
          create: (_) => LikeUnlikeBloc(PostRepo()),
        ),
        BlocProvider<AllPostBloc>(
          create: (_) => AllPostBloc(PostRepo()),
        ),
        BlocProvider<DetailPostBloc>(
          create: (_) => DetailPostBloc(PostRepo()),
        ),
        BlocProvider<PostCommentBloc>(
          create: (_) => PostCommentBloc(PostRepo()),
        ),
        BlocProvider<DeletePostBloc>(
          create: (_) => DeletePostBloc(PostRepo(),ProfileBloc(PostRepo())),
        ),
        BlocProvider<CreatePostBloc>(
          create: (_) => CreatePostBloc(PostRepo()),
        ),
        BlocProvider<EditPostBloc>(
          create: (_) => EditPostBloc(PostRepo()),
        ),
        BlocProvider<FollowUnfollowUserBloc>(
          create: (_) => FollowUnfollowUserBloc(UserRepo()),
        ),
        BlocProvider<EditProfileBloc>(
          create: (_) => EditProfileBloc(UserRepo()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: BaseString.appName,
        theme: ThemeData(
          fontFamily: BaseString.fProductSans,
        ),
        initialRoute: '/',
        onGenerateRoute: generateRoute,
      ),
    );
  }
}