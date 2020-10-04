import 'package:flutter/material.dart';

void LoadingDialog({BuildContext context,String msg}){
  showDialog(context: context,builder: (context)=>AlertDialog(
    content: Row(
      children: [
        CircularProgressIndicator(),
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(msg),
        )
      ],
    ),
  ));
}