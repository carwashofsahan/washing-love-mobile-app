import 'package:flutter/material.dart';

// topic widget
class ProgressPageHeaderTextUtils extends StatelessWidget {
  final String text;
  ProgressPageHeaderTextUtils({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
    );
  }
}
