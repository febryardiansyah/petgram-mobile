import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petgram_mobile_app/bloc/following_post_bloc/following_post_bloc.dart';
import 'package:petgram_mobile_app/bloc/register_bloc/register_bloc.dart';
import 'package:petgram_mobile_app/bloc/signin_bloc/sign_in_bloc.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';
import 'package:petgram_mobile_app/helpers/routes.dart';
import 'package:petgram_mobile_app/index.dart';
import 'package:petgram_mobile_app/repositories/auth_repo.dart';
import 'package:petgram_mobile_app/repositories/post_repo.dart';
import 'package:petgram_mobile_app/screens/login_screen/login_screen.dart';

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
