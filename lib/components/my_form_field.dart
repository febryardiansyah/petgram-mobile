import 'package:flutter/material.dart';
import 'package:petgram_mobile_app/constants/base_color.dart';

class MyFormField extends StatefulWidget {
  final TextInputType keyboardType;
  final ValueChanged<String> onFieldSubmitted;
  final Widget prefixIcon, suffixIcon;
  final String hintText;
  final bool obscureText;
  final String initialValue;
  final String labelText;
  final bool autoFocus;
  final TextEditingController textEditingController;

  const MyFormField({Key key,
    this.textEditingController,
    this.keyboardType,
    this.onFieldSubmitted,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.autoFocus = false,
    this.initialValue,
    this.labelText,
    this.hintText})
      : super(key: key);

  @override
  _MyFormFieldState createState() => _MyFormFieldState();
}

class _MyFormFieldState extends State<MyFormField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: TextFormField(
        controller: widget.textEditingController,
        keyboardType: widget.keyboardType,
        onFieldSubmitted: widget.onFieldSubmitted,
        obscureText: widget.obscureText,
        initialValue:widget.initialValue,
        autofocus: widget.autoFocus,
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          labelText: widget.labelText,
          border: InputBorder.none,
          fillColor: BaseColor.white,
          filled: true,
          focusColor: BaseColor.purple2,
          suffixIcon: widget.suffixIcon,
        ),
      ),
    );
  }
}
