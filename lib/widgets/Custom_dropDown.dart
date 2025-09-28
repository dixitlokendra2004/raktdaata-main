// import 'package:e_portfolio/core/utils/color_constant.dart';
// import 'package:e_portfolio/core/utils/image_constant.dart';
// import 'package:e_portfolio/core/utils/size_utils.dart';
// import 'package:e_portfolio/extensions.dart';
// import 'package:e_portfolio/theme/app_style.dart';
// import 'package:e_portfolio/ui/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';

import '../core/utils/color_constant.dart';
import '../core/utils/image_constant.dart';
import '../core/utils/size_utils.dart';
import '../theme/app_style.dart';
import 'custom_imageView.dart';

// import '../../translations/locale_keys.g.dart';

class CustomDropDown extends StatelessWidget {
  CustomDropDown({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.focusNode,
    this.icon,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.items,
    this.onChanged,
    this.applyValidator = true,
    this.selectedItem,
    this.validator,
    this.title = "",
  });

  String title;

  DropDownShape? shape;

  DropDownPadding? padding;

  DropDownVariant? variant;

  DropDownFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  FocusNode? focusNode;

  Widget? icon;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  List<String>? items;

  Function(String)? onChanged;

  bool applyValidator;

  Function? validator;

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: title.isNotEmpty,
          child: Container(
            margin: EdgeInsets.only(bottom: 7.Sh),
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.left,
              style: AppStyle.txtMontserratSemiBold15,
            ),
          ),
        ),
        alignment != null
            ? Align(
          alignment: alignment ?? Alignment.center,
          child: _buildDropDownWidget(),
        )
            : _buildDropDownWidget()
      ],
    );
  }

  _buildDropDownWidget() {
    return Container(
      width: width ?? double.maxFinite,
      margin: margin,
      child: DropdownButtonFormField(
        focusNode: focusNode,
        value: items!.contains(selectedItem) ? selectedItem : null,
        icon: Container(
          margin: getMargin(left: 30, right: 15),
          child: CustomImageView(
            svgPath: ImageConstant.imgArrowdown,
            color: AppColors.black,
          ),
        ),
        style: _setFontStyle(),
        decoration: _buildDecoration(),
        items: items?.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {
          onChanged!(value.toString());
        },
        validator: applyValidator
            ? (validator != null)
            ? (value) => validator!(value)
            : (value) {
          if (value == null ||
              value.toString().isEmpty ||
              value == "Select".trTrans) {
            return 'This field Cannot be empty';
          }
          return null;
        }
            : null,
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      prefixIcon: prefix,
      prefixIconConstraints: prefixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (fontStyle) {
      default:
        return TextStyle(
          color: ColorConstant.gray600,
          fontSize: getFontSize(
            14,
          ),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.29,
          ),
        );
    }
  }

  _setOutlineBorderRadius() {
    switch (shape) {
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueGray5002,
            width: 1,
          ),
        );
      case DropDownVariant.OutlineBluegray5002_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueGray5002,
            width: 1,
          ),
        );
      case DropDownVariant.None:
        return InputBorder.none;
      default:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueGray5002,
            width: 1,
          ),
        );
    }
  }

  _setFillColor() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002_1:
        return ColorConstant.whiteA700;
      default:
        return ColorConstant.gray100;
    }
  }

  _setFilled() {
    switch (variant) {
      case DropDownVariant.OutlineBluegray5002_1:
        return true;
      case DropDownVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (padding) {
      default:
        return getPadding(
          left: 13,
          top: 10,
          bottom: 10,
        );
    }
  }
}

enum DropDownShape {
  RoundedBorder8,
}

enum DropDownPadding {
  PaddingT13,
}

enum DropDownVariant {
  None,
  OutlineBluegray5002,
  OutlineBluegray5002_1,
}

enum DropDownFontStyle {
  MontserratMedium14,
}
