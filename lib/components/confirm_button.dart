import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class ConfirmButton extends StatelessWidget {
  final Function onTap;
  final double width, height;
  final Widget text;

  ConfirmButton({this.onTap, this.width, this.height, this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Container(
          child: text,
          width: width,
          height: height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            BaseColor.purple1,
            BaseColor.purple2,
          ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        ),
      ),
    );
  }
}
