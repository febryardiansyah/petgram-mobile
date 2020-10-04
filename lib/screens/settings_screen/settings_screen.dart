import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        color: BaseColor.purple2,
        child: Center(
          child: Text('Build with ♥ by Febry Ardiansyah',style: TextStyle(color: BaseColor.white),),
        )
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: BaseColor.purple2,
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Nothing for now :('),
      ),
    );
  }
}
