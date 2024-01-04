// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttercourse/services/services.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/login.dart';
import 'package:fluttercourse/view/screen/reg&login_Screen%20(auth)/signUp.dart';
import 'package:get/get.dart';

import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingServices myServices = Get.put(SettingServices());

    //var categoryId;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: //(
          FirebaseAuth.instance.currentUser == null
              // && FirebaseAuth.instance.currentUser!.emailVerified)
              ? Login()
              : Homepage(),
      routes: {
        "signup": (context) => SignUp(),
        "login": (context) => Login(),
        "HomePage": (context) => Homepage(),
        //"homeNote": (context) => homeNote(categoryId: widget.categoryId),
      },
    );
  }
}
