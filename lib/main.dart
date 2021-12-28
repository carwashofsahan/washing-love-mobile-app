import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:washing_love/auth_pages/page_login.dart';
import 'package:washing_love/landpage.dart';
import 'package:washing_love/models/user.dart';
import 'package:washing_love/screens/page_home.dart';
import 'package:washing_love/splash_screen.dart';
import 'package:washing_love/utils/utils_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:dcdg/dcdg.dart';

void main() async {
  // SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..backgroundColor = AppColors.color('2196F3')
    // ..indicatorColor = Colors.yellow
    // ..textColor = Colors.yellow
    // ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        title: 'Washing Love',
        theme: AppColors.lightTheme,
        home: SplashScreen(),
        // home: HomePage(),
        builder: EasyLoading.init(),
        routes: {
          '/login': (context) => LogInPage(),
          '/home': (context) => HomePage(),
          '/land': (context) => LandPage(),
        },
      ),
    );
  }
}
