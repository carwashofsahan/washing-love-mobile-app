import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_password.dart';

// new password screen
class CreateNewPassword extends StatefulWidget {
  final int otp;
  final String email;
  const CreateNewPassword({Key key, this.otp, this.email}) : super(key: key);

  @override
  _CreateNewPasswordState createState() => _CreateNewPasswordState(otp);
}

class _CreateNewPasswordState extends State<CreateNewPassword> {
  final int otp;
  _CreateNewPasswordState(this.otp);
  final _formKey = GlobalKey<FormState>();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();

  @override
  void dispose() {
    passController.dispose();
    confirmPassController.dispose();
    super.dispose();
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
          TextFormFieldPasswordUtils(
            validator: (pass) {
              if (pass == null || pass.isEmpty) {
                return 'Password is required';
              } else if( pass.toString().length < 8) {
                return 'Password must be at least 8 characters long';
              }
              return null;
            },
            textLabel: "New Password",
            controller: passController,
          ),
          TextFormFieldPasswordUtils(
            validator: (passCon) {
              if (passCon == null || passCon.isEmpty) {
                return 'Confirm Password is required';
              }
              if (passController.text != confirmPassController.text) {
                return "Password Do not match";
              }
              return null;
            },
            textLabel: "Confirm New Password",
            controller: confirmPassController,
          ),
          AuthButtonUtils(
            btnText: 'Set Password',
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                await CallApi(context).changePassword(
                    passController.text.toString(), widget.email, otp);
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
        child: AppBarCommonUtils('New Password'),
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
                'Create New Password to Secure',
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
}
