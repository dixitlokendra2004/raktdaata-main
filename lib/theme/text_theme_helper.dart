import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:raktdata_app/core/app_colors.dart';
import '../core/app_export.dart';

class TextThemeHelper {
  static get labelLarge12 => theme.textTheme.labelLarge!.copyWith(
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get bodyLargePrimaryContainer => theme.textTheme.bodyLarge!.copyWith(
        color: AppColors.black.withOpacity(1),
        fontSize: getFontSize(
          18,
        ),
      );
  static get titleSmallNotoSansPrimaryContainer =>
      theme.textTheme.titleSmall!.notoSans.copyWith(
        color: AppColors.black.withOpacity(1),
      );
  static get titleSmallMontserrat =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w600,
      );
  static get bodyLargeMontserrat => theme.textTheme.bodyLarge!.montserrat;
  static get titleMediumBold => theme.textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get bodySmallPrimaryContainer => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
      );
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleLargeOnPrimary => theme.textTheme.titleLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get labelLargeProductSansMedium =>
      theme.textTheme.labelLarge!.productSansMedium.copyWith(
        fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeNotoSansOnPrimary =>
      theme.textTheme.labelLarge!.notoSans.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get labelLargeBlack900 => theme.textTheme.labelLarge!.copyWith(
        color: appTheme.black900,
        fontSize: getFontSize(
          12,
        ),
      );
  static get headlineLargeOnPrimary32 =>
      theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: getFontSize(
          32,
        ),
      );
  static get headlineLarge32 => theme.textTheme.headlineLarge!.copyWith(
    color: AppColors.black,

    fontSize: getFontSize(
          32,
        ),
      );
  static get bodyLargeMontserratGray400 =>
      theme.textTheme.bodyLarge!.montserrat.copyWith(
        color: appTheme.gray400,
      );
  static get titleSmallInterPrimaryContainer =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontWeight: FontWeight.w700,
      );
  static get titleMediumNotoSansPrimaryContainer =>
      theme.textTheme.titleMedium!.notoSans.copyWith(
        color: Colors.white,
        fontSize: getFontSize(
          18,
        ),
      );
  static get bodyLarge18 => theme.textTheme.bodyLarge!.copyWith(
        fontSize: getFontSize(
          18,
        ),
      );
  static get labelLargeOnPrimarySemiBold =>
      theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
        fontSize: getFontSize(
          12,
        ),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallMontserratPrimaryContainer =>
      theme.textTheme.titleSmall!.montserrat.copyWith(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w600,
      );
  static get labelLargeOnPrimary12 => theme.textTheme.labelLarge!.copyWith(
    color:AppColors.white.withOpacity(1),
    fontSize: getFontSize(
          12,
        ),
      );
  static get labelLargeOnPrimary121 => theme.textTheme.labelLarge!.copyWith(
    color:AppColors.lightgrey.withOpacity(1),
    fontSize: getFontSize(
          16,
        ),
      );
  static get titleMediumPrimaryContainer_1 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.white.withOpacity(1),
        fontSize: getFontSize(
          18,
        ),
      );
  static get titleBoldPrimaryContainer_3 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.white.withOpacity(1),
        fontSize: getFontSize(
          22,
        ),
      );
  static get titleBoldBlackContainer_3 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.black.withOpacity(1),
        fontSize: getFontSize(
          22,
        ),
      );
  static get titleBoldBlackContainer_6 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.white.withOpacity(1),
        fontSize: getFontSize(
          14,
        ),
      );
  static get titleBoldBlackContainer_4 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.black.withOpacity(1),
        fontSize: getFontSize(
          20,
        ),
      );


  static get titleSmallPrimaryContainer_2 =>
      theme.textTheme.titleMedium!.copyWith(
        color:AppColors.white.withOpacity(1),
        fontSize: getFontSize(
          12,
        ),
      );


  static get labelLargeProductSansMediumOnPrimary =>
      theme.textTheme.labelLarge!.productSansMedium.copyWith(
        color: AppColors.white,
        fontSize: getFontSize(
          12,
        ),
      );
  static get titleSmallInter => theme.textTheme.titleSmall!.inter.copyWith(
        fontWeight: FontWeight.w700,
      );
  static get montserratOnPrimary => TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: getFontSize(
          7,
        ),
        fontWeight: FontWeight.w500,
      ).montserrat;
  static get montserratOnPrimary1 => TextStyle(
        color: AppColors.lightgrey,
        fontSize: getFontSize(
          14,
        ),
        fontWeight: FontWeight.w500,
      ).montserrat;
  static get montserratOnPrimary2 => TextStyle(
        color: AppColors.black,
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w500,
      ).montserrat;
  static get montserratOnPrimary3 => TextStyle(
        color: AppColors.lightGreen,
        fontSize: getFontSize(
          15,
        ),
        fontWeight: FontWeight.w500,
      ).montserrat;
  static get labelLargeSemiBold => theme.textTheme.labelLarge!.copyWith(
        fontSize: getFontSize(
          16,
        ),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallNotoSans => theme.textTheme.titleSmall!.notoSans;
  static get labelLargeNotoSans => theme.textTheme.labelLarge!.notoSans.copyWith( //canged color here
    color: AppColors.white,
  );
  static get labelLargeNotoSans1 => theme.textTheme.labelLarge!.notoSans.copyWith( //canged color here
    color: AppColors.lightgrey,
  );
  static get headlineLargeOnPrimary => theme.textTheme.headlineLarge!.copyWith(
        color: theme.colorScheme.onPrimary,
      );
  static get titleSmallSatoshiGray300 =>
      theme.textTheme.titleSmall!.satoshi.copyWith(
        color: appTheme.gray300,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallInterIndigoA700 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.indigoA700,
        fontWeight: FontWeight.w700,
      );
  static get titleSmallInterIndigoA700_1 =>
      theme.textTheme.titleSmall!.inter.copyWith(
        color: appTheme.indigoA700,
      );
  static get montserratPrimaryContainer => TextStyle(
        color: theme.colorScheme.primaryContainer.withOpacity(1),
        fontSize: getFontSize(
          7,
        ),
        fontWeight: FontWeight.w500,
      ).montserrat;
  static get bodyLargePrimaryContainer_1 => theme.textTheme.bodyLarge!.copyWith(
        color: AppColors.black.withOpacity(1),
      );
}

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get montserrat {
    return copyWith(
      fontFamily: 'Montserrat',
    );
  }

  TextStyle get satoshi {
    return copyWith(
      fontFamily: 'Satoshi',
    );
  }

  TextStyle get poppins {
    return copyWith(
      fontFamily: 'Poppins',
    );
  }

  TextStyle get notoSans {
    return copyWith(
      fontFamily: 'Noto Sans',
    );
  }

  TextStyle get productSansMedium {
    return copyWith(
      fontFamily: 'Product Sans Medium',
    );
  }
}
