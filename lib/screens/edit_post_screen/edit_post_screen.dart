import 'package:flutter/material.dart';

class EditPostScreen extends StatefulWidget {
  final String currentCaption;


  EditPostScreen({this.currentCaption});

  @override
  _EditPostScreenState createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}