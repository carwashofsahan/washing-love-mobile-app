import 'dart:async';

import 'package:flutter/material.dart';
import 'package:washing_love/api/api_call.dart';
import 'package:washing_love/auth_pages/page_new_pass.dart';
import 'package:washing_love/utils/logo.dart';
import 'package:washing_love/utils/utils_button_auth.dart';
import 'package:washing_love/utils/utils_app_bar_common.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// OTP screen
class OtpScreenMail extends StatefulWidget {
  final String inputMail;
  final String firstname;
  final String lastname;
  final String address;
  final String city;
  final String phone;
  final String password;
  final String role;
  final String type;

  const OtpScreenMail(
      {Key key,
      this.inputMail,
      this.address,
      this.city,
      this.firstname,
      this.lastname,
      this.password,
      this.role,
      this.phone,
      this.type})
      : super(key: key);

  @override
  _OtpScreenMailState createState() => _OtpScreenMailState(inputMail);
}

class _OtpScreenMailState extends State<OtpScreenMail> {
  final String inputMail;

  _OtpScreenMailState(this.inputMail);
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType> errorController;
  bool fullFill = false;
  bool hasError = false;
  String currentText;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController.close();
    textEditingController.dispose();
    super.dispose();
  }

  Widget _buildOtp() {
    return Column(
      children: [
        Form(
          key: formKey,
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.amber.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: true,
                //obscuringCharacter: '*',

                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                validator: (v) {
                  if (v.length < 4) {
                    fullFill = false;

                    return null;
                  } else {
                    fullFill = true;

                    return null;
                  }
                },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 40,
                  activeColor: Theme.of(context).accentColor,
                  selectedColor: Theme.of(context).primaryColor,
                  disabledColor: Colors.grey,
                  inactiveColor: Colors.black,
                  activeFillColor:
                      hasError ? Colors.amber.shade100 : Colors.red,
                ),
                cursorColor: Theme.of(context).primaryColor,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: false,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.white,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  //  print("Completed");
                },
                // onTap: () {
                //   print("Pressed");
                // },
                onChanged: (value) {
                  print(value);
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return false;
                },
              )),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Didn't receive the code? ",
              style: TextStyle(color: Colors.black54, fontSize: 15),
            ),
            TextButton(
                onPressed: () async {
                  await CallApi(context).sendSignupOtp(widget.inputMail);
                },
                child: Text(
                  "RESEND",
                  style: TextStyle(
                      color: Colors.amber[300],
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ))
          ],
        ),
        AuthButtonUtils(
          btnText: 'Confirm',
          onPressed: () async {
            if (fullFill) {
              formKey.currentState.validate();
              if (currentText.length == 4) {
                if (widget.type == 'signup') {
                  var res = await CallApi(context)
                      .checkSignupOtp(widget.inputMail, int.parse(currentText));
                  if (res)
                    await CallApi(context).signup(
                        widget.firstname,
                        widget.lastname,
                        widget.inputMail,
                        widget.address,
                        widget.city,
                        widget.phone,
                        widget.password,
                        widget.role);
                } else if (widget.type == 'reset') {
                  var res1 = await CallApi(context)
                      .checkOtp(widget.inputMail, int.parse(currentText));
                  if (res1)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateNewPassword(
                                otp: int.parse(currentText),
                                email: widget.inputMail)));
                } else if (widget.type == 'change') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateNewPassword(
                              otp: int.parse(currentText),
                              email: widget.inputMail)));
                }
              }
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: AppBarCommonUtils('OTP'),
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
                'Enter OTP We Just Sent to Your Mail',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              _buildOtp(),
            ],
          ),
        ),
      ),
    );
  }
}
