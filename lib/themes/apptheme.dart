import 'package:flutter/material.dart';

Color mainColor=Color(0xff026670);
//Color mainColor=Colors.indigo;
Color? grayColor=Colors.grey[200];
class AppColor {
  static const Color grey = Color(0xff8e8e8e);
  static const Color black = Color(0xff000000);
  // static const Color primaryColor = Color(0xff5DB1DF);
  static const Color backgroundcolor = Color(0xffF8F9FD) ;
  static const Color primaryColor = Color(0xffF2786D);
}

ThemeData themeEnglish = ThemeData(
  fontFamily: "PlayfairDisplay",
  textTheme: const TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.black),
      headline2: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyText1: TextStyle(
          height: 2,
          color: AppColor.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14),
      bodyText2: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);

ThemeData themeArabic = ThemeData(
  fontFamily: "Cairo",
  textTheme: const TextTheme(
      headline1: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 22, color: AppColor.black),
      headline2: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 26, color: AppColor.black),
      bodyText1: TextStyle(
          height: 2,
          color: AppColor.grey,
          fontWeight: FontWeight.bold,
          fontSize: 14),
      bodyText2: TextStyle(height: 2, color: AppColor.grey, fontSize: 14)),
  primarySwatch: Colors.blue,
);
