import 'package:flutter/material.dart';

// text input normal widget common
class TextFormFieldNormalUtils extends StatelessWidget {
  final String textLabel;
  final Function validator;
  final String hintText;
  final TextEditingController controller;
  final bool isPhonekey;
  final bool disabled;
  final int lines;

  TextFormFieldNormalUtils(
      {this.textLabel,
      this.validator,
      this.hintText,
      this.controller,
      this.isPhonekey,
      this.disabled,
      this.lines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        validator: validator,
        maxLines: lines == null ? 1 : lines,
        enabled: disabled == null ? true : false,
        keyboardType: (isPhonekey) ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          labelText: textLabel,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          hintText: hintText,
          contentPadding:
              EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        ));
  }
}
