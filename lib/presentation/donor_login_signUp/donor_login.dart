import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/splash_screen.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../View_model/auth_view_model_donor.dart';
import '../../theme/app_decoration.dart';
import '../../theme/button_theme_helper.dart';
import '../../theme/text_theme_helper.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_imageView.dart';
import '../../widgets/custom_textfrom_field.dart';
import '../widgets/custom_progress_bar.dart';
import 'donor_signUp.dart';

class DonorLogin extends StatefulWidget {
  const DonorLogin({Key? key}) : super(key: key);

  @override
  State<DonorLogin> createState() => _DonorLoginState();
}

class _DonorLoginState extends State<DonorLogin> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  late AuthViewModel _authViewModel;

  TextEditingController phoneController = TextEditingController();

  TextEditingController otpController = TextEditingController();

  bool _passwownVisible = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Donor Login".trTrans,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextThemeHelper.titleBoldPrimaryContainer_3,
        ),
        backgroundColor: AppColors.Red700,
        centerTitle: true,
      ),
      body: CustomProgressBar(
        visibility: _authViewModel.loading,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: AppDecoration.getScreenBg,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: getPadding(
                top: 210,
              ),
              child: Container(
                padding: getPadding(
                  left: 25,
                  top: 29,
                  right: 25,
                  bottom: 29,
                ),
                decoration: AppDecoration.outline.copyWith(
                  borderRadius: BorderRadiusStyle.roundedBorder18,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: getPadding(
                        top: 5,
                      ),
                      child: Text(
                        "Welcome back!".trTrans,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style:
                            TextThemeHelper.titleSmallNotoSansPrimaryContainer,
                      ),
                    ),
                    AbsorbPointer(
                      absorbing: _authViewModel.otpSent,
                      child: CustomTextFormField(
                        controller: phoneController,
                        margin: getMargin(top: 19),
                        textStyle: TextThemeHelper.bodyLargePrimaryContainer,
                        hintText: "Mobile Number".trTrans,
                        maxLength: 10,
                        onlyNumbers: true,
                        hintStyle: TextThemeHelper.bodyLargePrimaryContainer,
                        prefix: Container(
                          width: 3.Sw,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: getPadding(left: 10),
                            child: Text(
                              '+91',
                              style: TextThemeHelper.bodyLargePrimaryContainer,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Visibility(
                      visible: _authViewModel.otpSent,
                      child: CustomTextFormField(
                        controller: otpController,
                        margin: getMargin(top: 22),
                        textStyle: TextThemeHelper.bodyLargePrimaryContainer,
                        hintText: "OTP".trTrans,
                        maxLength: 6,
                        onlyNumbers: true,
                        hintStyle: TextThemeHelper.bodyLargePrimaryContainer,
                        textInputType: TextInputType.visiblePassword,
                        suffixConstraints: BoxConstraints(
                          maxHeight: getVerticalSize(50),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: !_authViewModel.otpSent,
                      child: CustomElevatedButton(
                        width: getHorizontalSize(360),
                        height: getVerticalSize(50),
                        text: "Send OTP".trTrans,
                        margin: getMargin(top: 21),
                        onTap: () {
                          _authViewModel.sendOtp(phoneController.text);
                        },
                        // 9755397694
                        buttonStyle: ButtonThemeHelper
                            .gradientnameblueA200namepurple900
                            .copyWith(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              double.maxFinite,
                              getVerticalSize(50),
                            ),
                          ),
                        ),
                        decoration: ButtonThemeHelper
                            .gradientnameblueA200namepurple900Decoration,
                        buttonTextStyle:
                            TextThemeHelper.titleMediumNotoSansPrimaryContainer,
                      ),
                    ),

                    Visibility(
                      visible: _authViewModel.otpSent,
                      child: CustomElevatedButton(
                        width: getHorizontalSize(360),
                        height: getVerticalSize(50),
                        text: "Continue".trTrans,
                        margin: getMargin(top: 21),
                        onTap: () {
                          _authViewModel.loginOrSignup(
                            phoneController.text,
                            otpController.text,
                          );
                        },
                        buttonStyle: ButtonThemeHelper
                            .gradientnameblueA200namepurple900
                            .copyWith(
                          fixedSize: MaterialStateProperty.all<Size>(
                            Size(
                              double.maxFinite,
                              getVerticalSize(50),
                            ),
                          ),
                        ),
                        decoration: ButtonThemeHelper
                            .gradientnameblueA200namepurple900Decoration,
                        buttonTextStyle:
                            TextThemeHelper.titleMediumNotoSansPrimaryContainer,
                      ),
                    ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Padding(
                    //     padding: getPadding(
                    //       top: 13,
                    //     ),
                    //     child: Text(
                    //       "Forgot password ?".trTrans,
                    //       overflow: TextOverflow.ellipsis,
                    //       textAlign: TextAlign.left,
                    //       style: TextThemeHelper
                    //           .titleSmallNotoSansPrimaryContainer,
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: Alignment.center,
                    //   child: Padding(
                    //     padding: getPadding(
                    //       top: 20,
                    //     ),
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         Get.to(() => DonorSignUp());
                    //         // SplashScreen());
                    //       },
                    //       child: Container(
                    //         color: Colors.transparent,
                    //         child: Padding(
                    //           padding: getPadding(all: 10),
                    //           child: Text(
                    //             "Don’t have an account ? Signup".trTrans,
                    //             overflow: TextOverflow.ellipsis,
                    //             textAlign: TextAlign.left,
                    //             style: TextThemeHelper
                    //                 .titleSmallNotoSansPrimaryContainer,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _authViewModel.disposeValues();
    super.dispose();
  }
}
