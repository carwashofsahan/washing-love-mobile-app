import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/auth_pages/page_mail_otp.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:washing_love/utils/utils_textform_field_normal.dart';
import 'package:washing_love/utils/utils_textform_field_password.dart';

// Register both detailer and customer screen
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String countryCode = "+94";
  bool _isLoading = false;
  String role = 'CUSTOMER';

  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final confirmPassController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final contactController = TextEditingController();

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passController.dispose();
    confirmPassController.dispose();
    contactController.dispose();
    addressController..dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  bool validatePassword(String pass) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(pass);
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildForm() {
      return Form(
        key: _formKey,
        child: Wrap(
          runSpacing: 20,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        role = 'CUSTOMER';
                      });
                    },
                    child: Card(
                      color: role == 'CUSTOMER'
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Customer',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        role = 'DETAILER';
                      });
                    },
                    child: Card(
                      color: role == 'DETAILER'
                          ? Theme.of(context).accentColor
                          : Colors.white,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            'Detailer',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            TextFormFieldNormalUtils(
              validator: (fName) {
                if (fName == null || fName.isEmpty) {
                  return 'First name is required';
                }
                return null;
              },
              textLabel: "First Name",
              controller: firstnameController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              // validator: (fName) {
              //   if (fName == null || fName.isEmpty) {
              //     return 'Name is required';
              //   }
              //   return null;
              // },
              textLabel: "Last Name",
              controller: lastnameController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              validator: (eMail) {
                if (eMail == null || eMail.isEmpty) {
                  return 'Email Name is required';
                } else if (!EmailValidator.validate(eMail)) {
                  return 'Invalid Email';
                }
                return null;
              },
              textLabel: "Email",
              controller: emailController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              validator: (suburb) {
                if (suburb == null || suburb.isEmpty) {
                  return 'Address is required';
                }
                return null;
              },
              textLabel: "Address",
              controller: addressController,
              isPhonekey: false,
            ),
            TextFormFieldNormalUtils(
              validator: (suburb) {
                if (suburb == null || suburb.isEmpty) {
                  return 'City is required';
                }
                return null;
              },
              textLabel: "City",
              controller: cityController,
              isPhonekey: false,
            ),
            Expanded(
              child: TextFormFieldNormalUtils(
                validator: (cnt) {
                  if (cnt == null || cnt.isEmpty) {
                    return 'Phone number is required';
                  }
                  if (cnt.length != 10) {
                    return "Please enter valid phone number";
                  }
                  return null;
                },
                textLabel: "Phone",
                controller: contactController,
                isPhonekey: true,
              ),
            ),
            TextFormFieldPasswordUtils(
              validator: (pass) {
                if (pass == null || pass.isEmpty) {
                  return 'Password is required';
                }
                if (pass.length < 8) {
                  return "Password at least 8 character";
                }
                return null;
              },
              textLabel: "Password",
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
              textLabel: "Confirm Password",
              controller: confirmPassController,
            ),
            AuthButtonUtils(
              btnText: 'Register',
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _signup();
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }

    Widget _buildBottomRow() {
      return Container(
        margin: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account, ",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/login'),
              // onTap: () => Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => LogInPage())),
              child: Text(
                "Login!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('Register'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              Logo(),
              SizedBox(
                height: 40,
              ),
              _buildForm(),
              _buildBottomRow()
            ],
          ),
        ),
      ),
    );
  }

  void _signup() async {
    var res =
        await CallApi(context).sendSignupOtp(emailController.text.toString());
    if (res)
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpScreenMail(
                    inputMail: emailController.text.toString(),
                    firstname: firstnameController.text.toString(),
                    lastname: lastnameController.text.toString(),
                    address: addressController.text.toString(),
                    city: cityController.text.toString(),
                    phone: contactController.text.toString(),
                    password: passController.text.toString(),
                    role: role,
                    type: 'signup',
                  )));
    // await CallApi(context).signup(
    //     firstnameController.text.toString(),
    //     lastnameController.text.toString(),
    //     emailController.text.toString(),
    //     addressController.text.toString(),
    //     cityController.text.toString(),
    //     countryCode.toString() + contactController.text.toString(),
    //     passController.text.toString(),
    //     role);
  }
}

Widget _sizedBox() {
  return SizedBox(
    height: 16,
  );
}
