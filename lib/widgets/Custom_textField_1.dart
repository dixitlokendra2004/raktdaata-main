import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:raktdata_app/widgets/util.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_style.dart';
import 'custom_imageView.dart';
import 'extensions.dart';

class CustomTextFormField_1 extends StatefulWidget {
  CustomTextFormField_1({
    this.shape,
    this.padding,
    this.variant,
    this.fontStyle,
    this.alignment,
    this.width,
    this.margin,
    this.controller,
    this.focusNode,
    this.isObscureText = false,
    this.applyValidator = true,
    this.onlyNumber = false,
    this.onlyText = false,
    this.decimalNumber = false,
    this.readOnly = false,
    this.isDatePicker = false,
    this.isFilePicker = false,
    this.onChange,
    this.onDateSelected,
    this.onFilePicked,
    this.onFileCanceled,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.onSubmitted,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.validator,
    this.title = "",
  });

  Function? onSubmitted;

  String title;

  TextFormFieldShape? shape;

  TextFormFieldPadding? padding;

  TextFormFieldVariant? variant;

  TextFormFieldFontStyle? fontStyle;

  Alignment? alignment;

  double? width;

  EdgeInsetsGeometry? margin;

  TextEditingController? controller;

  FocusNode? focusNode;

  bool isObscureText;

  TextInputAction? textInputAction;

  TextInputType? textInputType;

  int? maxLines;

  int? maxLength;

  String? hintText;

  Widget? prefix;

  BoxConstraints? prefixConstraints;

  Widget? suffix;

  BoxConstraints? suffixConstraints;

  bool applyValidator;

  bool onlyNumber;

  bool onlyText;

  bool decimalNumber;

  bool readOnly;

  bool isDatePicker;

  bool isFilePicker;

  Function? validator;

  final ValueChanged<String>? onChange;

  final ValueChanged<DateTime>? onDateSelected;

  final ValueChanged<File>? onFilePicked;

  final Function? onFileCanceled;

  @override
  State<CustomTextFormField_1> createState() => _CustomTextFormField_1State();
}

class _CustomTextFormField_1State extends State<CustomTextFormField_1> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    setupVariables();
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.title.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(bottom: 7.Sh),
              child: Text(
                widget.title,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                style: AppStyle.txtMontserratSemiBold15,
              ),
            ),
          ),
          widget.alignment != null
              ? Align(
                  alignment: widget.alignment ?? Alignment.center,
                  child: getTF(),
                )
              : getTF()
        ],
      ),
    );
  }

  _buildTextFormFieldWidget(bool absorb) {
    return Container(
      width: width ?? double.maxFinite,
      child: AbsorbPointer(
        absorbing: absorb,
        child: TextFormField(
          controller: controller,
          focusNode: widget.focusNode,
          onFieldSubmitted: (widget.onSubmitted != null)
              ? (s) => widget.onSubmitted!(s)
              : null,
          style: _setFontStyle(),
          onChanged: (s) {
            if (widget.onChange != null) {
              widget.onChange!(s);
            }
          },
          obscureText: widget.isObscureText,
          textInputAction: widget.textInputAction,
          keyboardType: widget.textInputType,
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          decoration: _buildDecoration(),
          readOnly:
              (widget.readOnly || widget.isFilePicker || widget.isDatePicker),
          inputFormatters: (widget.onlyNumber)
              ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
              : (widget.onlyText)
                  ? []
                  : (widget.decimalNumber)
                      ? [
                          FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                          TextInputFormatter.withFunction((oldValue, newValue) {
                            try {
                              final text = newValue.text;
                              if (text.isNotEmpty) double.parse(text);
                              return newValue;
                            } catch (e) {}
                            return oldValue;
                          }),
                        ]
                      : null,
          validator: widget.applyValidator
              ? (widget.validator != null)
                  ? (value) => widget.validator!(value)
                  : (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field Cannot be empty';
                      }
                      return null;
                    }
              : null,
        ),
      ),
    );
  }

  _buildDecoration() {
    return InputDecoration(
      hintText: widget.hintText ?? "",
      hintStyle: _setFontStyle(),
      border: _setBorderStyle(),
      enabledBorder: _setBorderStyle(),
      focusedBorder: _setBorderStyle(),
      disabledBorder: _setBorderStyle(),
      prefixIcon: widget.prefix,
      prefixIconConstraints: widget.prefixConstraints,
      suffixIcon: widget.suffix,
      suffixIconConstraints: widget.suffixConstraints,
      fillColor: _setFillColor(),
      filled: _setFilled(),
      isDense: true,
      contentPadding: _setPadding(),
    );
  }

  _setFontStyle() {
    switch (widget.fontStyle) {
      case TextFormFieldFontStyle.MontserratMedium12:
        return TextStyle(
          color: ColorConstant.whiteA700,
          fontSize: getFontSize(
            12,
          ),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.25,
          ),
        );
      case TextFormFieldFontStyle.MontserratMedium16:
        return TextStyle(
          color: ColorConstant.gray600,
          fontSize: getFontSize(
            16,
          ),
          fontFamily: 'Montserrat',
          fontWeight: FontWeight.w500,
          height: getVerticalSize(
            1.25,
          ),
        );
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
    switch (widget.shape) {
      case TextFormFieldShape.RoundedBorder12:
        return BorderRadius.circular(
          getHorizontalSize(
            12.00,
          ),
        );
      default:
        return BorderRadius.circular(
          getHorizontalSize(
            6.00,
          ),
        );
    }
  }

  _setBorderStyle() {
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.FillWhiteA700:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide.none,
        );
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return OutlineInputBorder(
          borderRadius: _setOutlineBorderRadius(),
          borderSide: BorderSide(
            color: ColorConstant.blueGray5002,
            width: 1,
          ),
        );
      case TextFormFieldVariant.None:
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
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return ColorConstant.buttonThemeSecondary;
      case TextFormFieldVariant.FillWhiteA700:
        return ColorConstant.whiteA700;
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return ColorConstant.whiteA700;
      default:
        return ColorConstant.gray100;
    }
  }

  _setFilled() {
    switch (widget.variant) {
      case TextFormFieldVariant.FillYellow70033:
        return true;
      case TextFormFieldVariant.FillWhiteA700:
        return true;
      case TextFormFieldVariant.OutlineBluegray5002_1:
        return true;
      case TextFormFieldVariant.None:
        return false;
      default:
        return true;
    }
  }

  _setPadding() {
    switch (widget.padding) {
      case TextFormFieldPadding.PaddingT13:
        return getPadding(
          left: 12,
          top: 13,
          right: 12,
          bottom: 13,
        );
      case TextFormFieldPadding.PaddingT28:
        return getPadding(
          left: 15,
          top: 28,
          right: 15,
          bottom: 28,
        );
      case TextFormFieldPadding.PaddingAll6:
        return getPadding(
          all: 6,
        );
      case TextFormFieldPadding.PaddingT16:
        return getPadding(
          top: 16,
          right: 16,
          bottom: 16,
        );
      default:
        return getPadding(
          left: 13,
          top: 13,
          bottom: 13,
        );
    }
  }

  Widget getTF() {
    if (widget.isDatePicker) {
      return GestureDetector(
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: Get.context!,
            initialDate: DateTime.now(),
            firstDate: DateTime(2015, 8),
            lastDate: DateTime.now(),
            // DateTime.now().add(Duration(days: 365)),
          );
          if (picked != null) {
            controller.text = picked.formatDate;
            if(widget.onDateSelected != null) {
              widget.onDateSelected!(picked);
            }
          }
        },
        child: _buildTextFormFieldWidget(true),
      );
    } else if (widget.isFilePicker) {
      return Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            // onTap: () async {
            //   File? file = await pickFile();
            //   if (file != null) {
            //     widget.onFilePicked!(file);
            //      // controller.text = file.fileName;
            //     setState(() {});
            //   }
            // },
            onTap: () async {
              File? file = await pickFile();
              if (file != null) {
                widget.onFilePicked!(file);
                String fileName = file.path.split('/').last;
                controller.text = fileName;
                setState(() {});
              }
            },

            child: _buildTextFormFieldWidget(true),
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            width: 40.Sw,
            child: GestureDetector(
              onTap: () => getIconTap(),
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ),
        ],
      );
    } else {
      return _buildTextFormFieldWidget(false);
    }
  }

  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        int maxSize = 3 * 1024 * 1024; // 3MB in bytes

        if (result.files.single.size <= maxSize) {
          String path = result.files.single.path ?? "";

          // Check if the file is in jpg format
          print(path.toLowerCase());
          if (path.isNotEmpty &&
              (path.toLowerCase().endsWith(".jpg") ||
                  path.toLowerCase().endsWith(".jpeg") ||
                  path.toLowerCase().endsWith(".png"))) {
            return File(path);
          } else {
            Util.getSnackBar("Please select a Image");
          }
        } else {
          Util.getSnackBar(
              "Please select a file with size less than 3MB".trTrans);
        }
      }

      return null;
    } on PlatformException catch (e) {
      print('Error: ${e.toString()}');
      return null;
    } catch (e) {
      print('Error: ${e.toString()}');
      return null;
    }
  }

  void setupVariables() {
    if (widget.isObscureText || widget.isFilePicker || widget.isDatePicker) {
      widget.maxLines = 1;
    }
    if (widget.isFilePicker || widget.isDatePicker) {
      widget.suffixConstraints = BoxConstraints(
        maxHeight: getVerticalSize(
          44,
        ),
      );
      if (widget.isFilePicker) {
        widget.suffix = Container(
          margin: getMargin(
            left: 30,
            top: 14,
            right: 15,
            bottom: 14,
          ),
          child: CustomImageView(
            svgPath: controller.text.trim().isNotEmpty
                ? ImageConstant.imgX
                : ImageConstant.imgUpload,
            color: AppColors.black,
          ),
        );
      } else {
        widget.suffix = Container(
          margin: getMargin(
            left: 30,
            top: 14,
            right: 15,
            bottom: 14,
          ),
          child: CustomImageView(
            svgPath: ImageConstant.imgCalendar,
            color: AppColors.black,
          ),
        );
      }
    }
  }

  getIconTap() async {
    if (widget.onFileCanceled != null && controller.text.trim().isNotEmpty) {
      controller.text = "";
      setState(() {});
      widget.onFileCanceled!();
      // Util.showBottomSheet(
      //   child: DeleteBottomSheet(
      //     body: LocaleKeys.areYouSureToDeleteThisFile.translate,
      //     onTap: () {
      //
      //     },
      //   ),
      // );
    } else if (controller.text.trim().isEmpty && widget.isFilePicker) {
      File? file = await pickFile();
      if (file != null) {
        widget.onFilePicked!(file);
        String fileName = file.path.split('/').last;
        controller.text = fileName;
        setState(() {});
      }
    }
  }
}

enum TextFormFieldShape {
  RoundedBorder6,
  RoundedBorder12,
}

enum TextFormFieldPadding {
  PaddingT13,
  PaddingT13_1,
  PaddingT28,
  PaddingAll6,
  PaddingT16,
}

enum TextFormFieldVariant {
  None,
  OutlineBluegray5002,
  FillYellow70033,
  FillWhiteA700,
  OutlineBluegray5002_1,
}

enum TextFormFieldFontStyle {
  MontserratMedium14,
  MontserratMedium12,
  MontserratMedium16,
}
