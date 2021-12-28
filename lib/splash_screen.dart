import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// splash screen
class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, '/land');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        color: Colors.amber[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 5,
            ),
            Center(
                child: Text(
              'Washing Love',
              style: TextStyle(
                  fontSize: 35,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            )),
            Image.asset(
              "assets/splash.gif",
              // height: 125.0,
              width: double.infinity,
            ),
            Center(
                child: Text(
              'Sri lanka\'s only Car Wash app',
              style: TextStyle(
                  fontSize: 18, color: Theme.of(context).primaryColor),
            )),
          ],
        ),
      ),
    );
  }
}
