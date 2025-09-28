//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// class LocalizationChecker{
// static changeLanguage(BuildContext context){
//   Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
//   if(currentLocal ==   Locale('en' ,'US')) {
//     EasyLocalization.of(context)!.setLocale( Locale ('hi','IN' ));
//
//   }else{
//     EasyLocalization.of(context)!.setLocale( Locale ('en','US' ));
//
//   }
// }
// }
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:raktdata_app/widgets/config_screen.dart';
import 'package:raktdata_app/widgets/splash_screen.dart';

import '../donor_login_signUp/donor_login.dart';

class LocalizationChecker {
  static void changeLanguage(BuildContext context) {

    Locale? currentLocal = EasyLocalization.of(context)!.currentLocale;
    if (currentLocal == Locale('en', 'US')) {
      EasyLocalization.of(context)!.setLocale(Locale('hi', 'IN'));
    } else {
      EasyLocalization.of(context)!.setLocale(Locale('en', 'US'));
    }
  }
}
