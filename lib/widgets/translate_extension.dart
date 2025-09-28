import 'package:easy_localization/easy_localization.dart';

extension EasyLocalizationOverride on String {
  String get trTrans {
    return this.toString().tr();
  }
}