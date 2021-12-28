import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';

import 'page_mail_otp.dart';

// Forgot password screen
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();

    super.dispose();
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
                return 'Email  is required';
              } else if (!EmailValidator.validate(eMail)) {
                return 'Invalid Email';
              }
              return null;
            },
            textLabel: "Email",
            controller: emailController,
            isPhonekey: false,
          ),
          AuthButtonUtils(
            btnText: 'Reset',
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _onPressed();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Reset Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Logo(),
              SizedBox(height: 20.0),
              Text(
                'Enter your Email to Reset Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              _buildForm(),
            ],
          ),
        ),
      ),
    );
  }

  _onPressed() async {
    var res = await CallApi(context).sendOtp(emailController.text.toString());
    if (res)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreenMail(
                    inputMail: emailController.text,
                    type: 'reset',
                  )));
  }
}
