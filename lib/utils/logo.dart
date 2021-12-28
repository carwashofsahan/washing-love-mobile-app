import 'package:flutter/material.dart';

// commont text to show app name
class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Washing Love',
      style: TextStyle(fontSize: 32, color: Theme.of(context).primaryColor),
    ));
  }
}
