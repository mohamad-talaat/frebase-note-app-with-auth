import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/forgetpassword/resetPassword.dart';
import 'package:get/get.dart';

import '../../../../themes/apptheme.dart';

class VerfiyCode extends StatelessWidget {
  const VerfiyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    dynamic fontcolor = isDark ? Colors.white : Colors.black;

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: ListView(children: [
          const SizedBox(height: 20),
          Text(
            "Check code",
            textAlign: TextAlign.center,
            style:
                TextStyle(color: fontcolor, fontSize: 40, fontFamily: "Cairo"),
          ),
          const SizedBox(height: 30),
          Text(
            "Please Enter The Digit Code Sent To wael@gmail.com",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: fontcolor,
                fontSize: 20,
                fontFamily: "Cairo",
                fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 40),
          OtpTextField(
            textStyle: TextStyle(color: fontcolor),
            fieldWidth: 50.0,
            borderRadius: BorderRadius.circular(20),
            numberOfFields: 5,
            borderColor: mainColor,
            //set to true to show as box or false to show as dash
            showFieldAsBox: true,
            //runs when a code is typed in
            onCodeChanged: (String code) {
              //handle validation or checks here
            },
            //runs when every textfield is filled
            onSubmit: (String verificationCode) {
              Get.to(resetPassword());
            }, // end onSubmit
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
