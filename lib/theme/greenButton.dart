import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/theme/theme_helper.dart';

import '../core/utils/size_utils.dart';

class GreenButton {
  static ButtonStyle get gradientnameblueA200namepurple900 =>
      ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
      );
  static BoxDecoration get gradientnameblueA200namepurple900Decoration =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        ),
        gradient: LinearGradient(
          begin: Alignment(
            0.1,
            0,
          ),
          end: Alignment(
            0.92,
            0,
          ),
          colors: [
            AppColors.lightGreen,
            AppColors.lightGreen,

          ],
        ),
      );
  static ButtonStyle get fillPrimaryContainer => ElevatedButton.styleFrom(
    backgroundColor: theme.colorScheme.primaryContainer,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        200,
      ),
    ),
  );
  static ButtonStyle get fillIndigoA700 => ElevatedButton.styleFrom(
    backgroundColor: appTheme.indigoA700,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        10,
      ),
    ),
  );
  static ButtonStyle get none => ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
    elevation: MaterialStateProperty.all<double>(0),
  );
}
