import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:washing_love/api/api_consts.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/auth_pages/page_register.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';
import 'package:washing_love/utils/utils_textform_field_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page_forgot_pass.dart';

// login screen
class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  bool checkValue = true;
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future<SharedPreferences> localStorage = SharedPreferences.getInstance();
    localStorage.then((value) {
      var token = value.getString(AppConstants.spToken);
      if (token != null) {
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.of(context).pushNamed("/home");
      }
    });
  }

  bool validatePassword(String pass) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(pass);
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Wrap(
        runSpacing: 20,
        children: [
          TextFormFieldNormalUtils(
            validator: (eMail) {
              if (eMail == null || eMail.isEmpty) {
                return 'Email is required';
              } else if (!EmailValidator.validate(eMail)) {
                return 'Invalid Email';
              }
              return null;
            },
            textLabel: "Email",
            controller: emailController,
            isPhonekey: false,
          ),
          TextFormFieldPasswordUtils(
            validator: (pass) {
              if (pass == null || pass.isEmpty) {
                return 'Password is required';
              }
              return null;
            },
            textLabel: "Password",
            controller: passController,
          ),
          AuthButtonUtils(
            btnText: 'Login',
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                // login mechanism
                var callLoginApi = CallApi(context);
                await callLoginApi.login(
                    emailController.text, passController.text);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBottomText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //Todo Checkbox
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Transform.scale(
              scale: .9,
              child: Checkbox(
                checkColor: Colors.white,
                activeColor: Theme.of(context).accentColor,
                value: this.checkValue,
                onChanged: (bool value) {
                  setState(() {
                    this.checkValue = value;
                  });
                },
              ),
            ),
            Text('Remember Me'),
          ],
        ),

        InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPassword())),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Theme.of(context).accentColor,
              ),
            )),
      ],
    );
  }

  Widget _buildBottomLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "New User  ",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage())),
          child: Text(
            "Register!",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Logo(),
              SizedBox(
                height: 40,
              ),
              _buildForm(),
              SizedBox(
                height: 10,
              ),
              _buildBottomText(),
              SizedBox(
                height: 10,
              ),
              const Divider(
                height: 20,
                thickness: 2,
                //   indent: 20,
//endIndent: 20,
              ),
              _buildBottomLink(),
            ],
          ),
        ),
      ),
    );
  }
}
