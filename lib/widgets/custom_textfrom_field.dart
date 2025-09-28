import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raktdata_app/core/app_colors.dart';

import '../core/utils/size_utils.dart';
import '../theme/theme_helper.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.fillColor,
    this.filled = false,
    this.contentPadding,
    this.defaultBorderDecoration,
    this.enabledBorderDecoration,
    this.focusedBorderDecoration,
    this.disabledBorderDecoration,
    this.validator,
    this.onChange,
    this.maxLength,
    this.onlyNumbers = false,
  }) : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final Color? fillColor;

  final bool? filled;

  final EdgeInsets? contentPadding;

  final InputBorder? defaultBorderDecoration;

  final InputBorder? enabledBorderDecoration;

  final InputBorder? focusedBorderDecoration;

  final InputBorder? disabledBorderDecoration;

  final FormFieldValidator<String>? validator;

  final Function? onChange;

  final int? maxLength;

  final bool onlyNumbers;

  List<TextInputFormatter> inputFormatters = [];

  @override
  Widget build(BuildContext context) {
    if(onlyNumbers) {
      inputFormatters.add(FilteringTextInputFormatter.digitsOnly);
      textInputType = TextInputType.phone;
    }
    if(maxLength != null) {
      inputFormatters.add(LengthLimitingTextInputFormatter(maxLength));
    }
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget,
          )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => Container(
        width: width ?? double.maxFinite,
        margin: margin,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus!,
          style: textStyle,
          onChanged: (s) {
            if (onChange != null) onChange!(s);
          },
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle,
        prefixIcon: prefix,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        suffixIconConstraints: suffixConstraints,
        fillColor: fillColor,
        filled: filled,
        isDense: true,
        contentPadding: contentPadding ??
            getPadding(
              left: 13,
              top: 15,
              right: 13,
              bottom: 15,
            ),
        border: defaultBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  10.00,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.black,
                // theme.colorScheme.primaryContainer.withOpacity(1),
                width: 1,
              ),
            ),
        enabledBorder: enabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  10.00,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.black,
                // theme.colorScheme.primaryContainer.withOpacity(1),
                width: 1,
              ),
            ),
        focusedBorder: focusedBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  10.00,
                ),
              ),
              borderSide: BorderSide(
                color: AppColors.black,
                // theme.colorScheme.primaryContainer.withOpacity(1),
                width: 1,
              ),
            ),
        disabledBorder: disabledBorderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                getHorizontalSize(
                  10.00,
                ),
              ),
              borderSide: BorderSide(
                color: theme.colorScheme.primaryContainer.withOpacity(1),
                width: 1,
              ),
            ),
      );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineGray200 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        borderSide: BorderSide(
          color: appTheme.gray200,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlineGray3007f => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        borderSide: BorderSide(
          color: appTheme.gray3007f,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlineOnPrimary => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        ),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimary,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlineBluegray400 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            10.00,
          ),
        ),
        borderSide: BorderSide(
          color: appTheme.blueGray400,
          width: 1,
        ),
      );

  static OutlineInputBorder get outlineOnPrimaryTL8 => OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          getHorizontalSize(
            8.00,
          ),
        ),
        borderSide: BorderSide(
          color: theme.colorScheme.onPrimary.withOpacity(0.5),
          width: 1,
        ),
      );
}
