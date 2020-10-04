import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';
import 'package:petgram_mobile_app/constants/base_string.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _start(){
    Future.delayed(Duration(
      seconds: 5
    ),(){
      Navigator.pushReplacementNamed(context, '/index');
    });
  }

  //Waking up api when a sleep
  void initApi()async{
    Dio dio = Dio();
    await dio.get('https://petgram-server.glitch.me/');
  }
  @override
  void initState() {
    super.initState();
    initApi();
    _start();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Text('Petgram',style: TextStyle(fontFamily: BaseString.fBillabong,fontSize: 50,color: BaseColor.white),),
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              BaseColor.purple2,
              BaseColor.red
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft
          )
        ),
      )
    );
  }
}
