import 'package:flutter/material.dart';
import 'package:washing_love/utils/utils_theme.dart';

// auth button. used as all submit buttons
class AuthButtonUtils extends StatelessWidget {
  final String btnText;
  final Function onPressed;
  AuthButtonUtils({this.btnText, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Theme.of(context).accentColor,
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
