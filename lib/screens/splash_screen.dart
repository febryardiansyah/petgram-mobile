import 'package:flutter/material.dart';

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
  @override
  void initState() {
    super.initState();
    _start();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('SplashScreen'),
      ),
    );
  }
}
