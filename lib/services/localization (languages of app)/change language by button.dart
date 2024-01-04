//
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import '../services.dart';
//
//-
// class buttonLanguageChange extends GetxController{
// Locale intialLanguage = sharedPrefer?.getString('language') == 'ar'? Locale('ar'):Locale('en' );
//    void changeLanguage (String _languageCode){
//      Locale _locale =  Locale(_languageCode);
//      myservices.sharedPrefer!.setString('language', _languageCode);
//      Get.updateLocale(_locale); }}
//
// // in main class
//     buttonLanguageChange cont = Get.put(buttonLanguageChange());
//
//
// // in main method
//   // locale: Get.deviceLocale, //return the language device
//   //    locale: cont.intialLanguage,  //return the language device
//   //     translations: mylocale(), // return the class of translation // the initial language
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/apptheme.dart';
import '../services.dart';

LocaleController langController = Get.put(LocaleController());

class LocaleController extends GetxController {
  Locale? language;
  ThemeData appTheme = themeEnglish;
  SettingServices settingServices = Get.find();

  changeLanguage(String langcode) {
    Locale locale = Locale(langcode);
    settingServices.sharedPrefer?.setString("lang", langcode);
    appTheme = langcode == "ar" ? themeArabic : themeEnglish;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
  }

  @override
  void onInit() {
    String? sharedPrefLang = settingServices.sharedPrefer?.getString("lang");
    if (sharedPrefLang == "ar") {
      language = const Locale("ar");
      appTheme = themeArabic;
    } else if (sharedPrefLang == "en") {
      language = const Locale("en");
      appTheme = themeEnglish;
    } else {
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
