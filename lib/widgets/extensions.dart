import 'dart:io';


import '../core/app_string.dart';
import 'package:intl/intl.dart';

extension Extensions on dynamic {
  String get formatDate {
    if (this is DateTime) {
      return DateFormat('yyyy-MM-dd').format(this);
    } else {
      return AppStrings.NA;
    }
  }

  String get fileName => (this is File)
      ? basename(this.path)
      : (this is String)
      ? (this.contains('/'))
      ? this.split('/').last
      : (this.contains(r'\'))
      ? this.split(r'\').last
      : AppStrings.NA
      : AppStrings.NA;

  String get fileNameWithoutNA => (this is File)
      ? basename(this.path)
      : (this is String)
      ? (this.contains('/'))
      ? this.split('/').last
      : ""
      : "";
}