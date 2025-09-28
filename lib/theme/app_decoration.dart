import 'package:flutter/material.dart';
import 'package:raktdata_app/theme/theme_helper.dart';

import '../core/app_colors.dart';
import '../core/utils/size_utils.dart';

class AppDecoration {
  static BoxDecoration get fill => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );

  static BoxDecoration get getScreenBg => BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment(
        -1,
        -1,
      ),
      end: Alignment(
        -0.28,
        -0.28,
      ),
      colors: [
        AppColors.white,
        AppColors.white,

        // appTheme.deepRed400,
        // theme.colorScheme.onPrimary,
      ],
    ),
  );

  static BoxDecoration get outline => BoxDecoration();

  static BoxDecoration
      get gradientnamedeeppurple50nameprimaryContaineropacity1 => BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0,
                0,
              ),
              end: Alignment(
                0.5,
                0.39,
              ),
              colors: [
                appTheme.deepPurple50,
                theme.colorScheme.primaryContainer.withOpacity(1),
              ],
            ),
          );

  static BoxDecoration
      get gradientnamedeeppurple100nameprimaryContaineropacity1 =>
          BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0,
                0,
              ),
              end: Alignment(
                0.5,
                0.39,
              ),
              colors: [
                appTheme.deepPurple100,
                theme.colorScheme.primaryContainer.withOpacity(1),
              ],
            ),
          );

  static BoxDecoration get outline2 => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.73),
          width: getHorizontalSize(
            7,
          ),
          strokeAlign: strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              -25,
              25,
            ),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0.38,
          ),
          end: Alignment(
            0.5,
            1,
          ),
          colors: [
            theme.colorScheme.errorContainer,
            appTheme.black900,
            theme.colorScheme.onPrimary,
          ],
        ),
      );

  static BoxDecoration get gradientnameonPrimaryContainernameblack900 =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0.5,
            0,
          ),
          end: Alignment(
            0.5,
            4.9,
          ),
          colors: [
            theme.colorScheme.onPrimaryContainer,
            appTheme.black900,
          ],
        ),
      );

  static BoxDecoration
      get gradientnamedeeppurple5002nameprimaryContaineropacity1 =>
          BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0,
                0,
              ),
              end: Alignment(
                0.5,
                0.39,
              ),
              colors: [
                appTheme.deepPurple5002,
                theme.colorScheme.primaryContainer.withOpacity(1),
              ],
            ),
          );

  static BoxDecoration get outline1 => BoxDecoration();

  static BoxDecoration get outline4 => BoxDecoration(
        color: theme.colorScheme.onPrimary,
        border: Border.all(
          color: appTheme.black900.withOpacity(0.73),
          width: getHorizontalSize(
            7,
          ),
          strokeAlign: strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              -25,
              25,
            ),
          ),
        ],
      );

  static BoxDecoration get outline3 => BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        border: Border.all(
          color: appTheme.black900.withOpacity(0.73),
          width: getHorizontalSize(
            7,
          ),
          strokeAlign: strokeAlignOutside,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: getHorizontalSize(
              2,
            ),
            blurRadius: getHorizontalSize(
              2,
            ),
            offset: Offset(
              -25,
              25,
            ),
          ),
        ],
      );

  static BoxDecoration get gradientnameindigo50nameprimaryContaineropacity1 =>
      BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(
            0,
            0,
          ),
          end: Alignment(
            0.5,
            0.39,
          ),
          colors: [
            appTheme.indigo50,
            theme.colorScheme.primaryContainer.withOpacity(1),
          ],
        ),
      );

  static BoxDecoration
      get gradientnamedeeppurple5001nameprimaryContaineropacity1 =>
          BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(
                0,
                0,
              ),
              end: Alignment(
                0.5,
                0.39,
              ),
              colors: [
                appTheme.deepPurple5001,
                theme.colorScheme.primaryContainer.withOpacity(1),
              ],
            ),
          );

  static BoxDecoration get txtOutline => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.primaryContainer.withOpacity(1),
          width: getHorizontalSize(
            1,
          ),
        ),
      );

  static BoxDecoration get txtOutline1 => BoxDecoration(
        border: Border.all(
          color: theme.colorScheme.onPrimary,
          width: getHorizontalSize(
            1,
          ),
        ),
      );
}

class BorderRadiusStyle {
  static BorderRadius customBorderTL20 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
  );

  static BorderRadius customBorderBR30 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        2,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        12,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        30,
      ),
    ),
  );

  static BorderRadius roundedBorder15 = BorderRadius.circular(
    getHorizontalSize(
      15,
    ),
  );

  static BorderRadius roundedBorder12 = BorderRadius.circular(
    getHorizontalSize(
      12,
    ),
  );

  static BorderRadius txtCircleBorder9 = BorderRadius.circular(
    getHorizontalSize(
      9,
    ),
  );

  static BorderRadius customBorderTL15 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        15,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        2,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        15,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        15,
      ),
    ),
  );

  static BorderRadius customBorderTL201 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        5,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        10,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
  );

  static BorderRadius roundedBorder18 = BorderRadius.circular(
    getHorizontalSize(
      18,
    ),
  );

  static BorderRadius customBorderTL202 = BorderRadius.only(
    topLeft: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
    topRight: Radius.circular(
      getHorizontalSize(
        1,
      ),
    ),
    bottomLeft: Radius.circular(
      getHorizontalSize(
        15,
      ),
    ),
    bottomRight: Radius.circular(
      getHorizontalSize(
        20,
      ),
    ),
  );
}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;
