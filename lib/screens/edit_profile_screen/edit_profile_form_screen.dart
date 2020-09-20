import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class EditProfileFormScreen extends StatelessWidget {
  final Widget child;
  final Function onDone;
  EditProfileFormScreen({this.child,this.onDone});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(color: BaseColor.black, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.check,color: BaseColor.red,),
            onPressed: onDone,
          )
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: BaseColor.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: child,
      ),
    );
  }
}
