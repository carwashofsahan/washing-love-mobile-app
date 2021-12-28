import 'package:flutter/material.dart';

// text input password widget common
class TextFormFieldPasswordUtils extends StatelessWidget {
  final String textLabel;
  final Function validator;
  final String hintText;
  final TextEditingController controller;
  TextFormFieldPasswordUtils(
      {this.textLabel, this.validator, this.hintText, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: true,
        validator: validator,
        decoration: InputDecoration(
          // labelStyle: TextStyle(color: Colors.black, fontSize: 14),
          labelText: textLabel,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ));
  }
}
