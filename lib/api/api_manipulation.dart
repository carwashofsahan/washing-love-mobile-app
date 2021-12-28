import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:washing_love/api/api_consts.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/screens/page_home.dart';
import 'package:washing_love/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Check user logged in and navigate proper page
class ApiManipulation {
  final BuildContext context;
  ApiManipulation(this.context);
  var token;

  validateUser() {
    _isLoggedIn().then((loggedIn) {
      if (loggedIn) {
        fetchUser().then((user) {
          if (user != null) {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => HomePage(
            //               user: user,
            //               token: token,
            //             )));
            Navigator.of(context).pushNamed("/home");
          } else {
           // CallApi(context).showLoading();

          //  Timer(Duration(seconds: 3), () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LogInPage()));

              Navigator.pushNamed(context, '/login');
              //CallApi(context).stopLoading();
          //  });
          }
        });
      } else {
       // CallApi(context).showLoading();

       // Timer(Duration(seconds: 3), () {
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => LogInPage()));
          Navigator.pushNamed(context, '/login');
          //CallApi(context).stopLoading();
       // });
      }
    });
  }

  Future<bool> _isLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString(AppConstants.spToken);
    if (token != null) {
      return true;
    }
    return false;
  }

  Future<User> fetchUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var str = sharedPreferences.getString(AppConstants.spUser);
    print('STR: $str');
    if (str != null) {
      return User.fromJson(json.decode(str));
    }
    return null;
  }

  refreshUser(String email, String password) async {
    CallApi(context).login(email, password);
  }
}
