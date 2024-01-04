import 'package:flutter/material.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/forgetpassword/verifycode.dart';
import 'package:get/get.dart';

import '../../../../themes/apptheme.dart';
import '../../../widget/widgets screen (all widgets).dart';

GlobalKey<FormState> formstate = GlobalKey<FormState>();
final TextEditingController emailController = TextEditingController();

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    dynamic fontcolor = isDark ? Colors.white : Colors.black;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: formstate,
          child: ListView(children: [
            const SizedBox(height: 20),
            SizedBox(height: 30),
            Text(
              "Verification code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontcolor, fontSize: 40, fontFamily: "Cairo"),
            ),
            const SizedBox(height: 30),
            Text(
              "Enter Your Email To Change Your Password",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: fontcolor,
                  fontSize: 20,
                  fontFamily: "Cairo",
                  fontWeight: FontWeight.w200),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormFieldScreen(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              label: "Enter Your Email",
              validator: (value) {
                return ValidatorScreen(value!, 5, 90, "email");
              },
            ),
            SizedBox(
              height: 40,
            ),
            MaterialButtonScreen(
                titleOfButton: "Save",
                fontSize: 25,
                colorOfButton: mainColor,
                widthOfButton: double.infinity,
                onPressed: () {
                  Get.to(VerfiyCode());
                }),
            const SizedBox(height: 40),
          ]),
        ),
      ),
    );
  }
}
