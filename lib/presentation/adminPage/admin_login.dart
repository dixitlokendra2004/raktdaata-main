import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../../View_model/auth_admin.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/button_theme_helper.dart';
import '../../theme/text_theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_imageView.dart';
import '../../widgets/custom_textfrom_field.dart';
import '../widgets/custom_progress_bar.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  late AuthAdminViewModel _authViewModel;

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool _passwownVisible = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthAdminViewModel>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Admin Login".trTrans,
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
                    CustomTextFormField(
                      controller: emailController,
                      margin: getMargin(
                        top: 19,
                      ),
                      textStyle: TextThemeHelper.bodyLargePrimaryContainer,
                      hintText: "Email".trTrans,
                      hintStyle: TextThemeHelper.bodyLargePrimaryContainer,
                      textInputType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    CustomTextFormField(
                      controller: passwordController,
                      margin: getMargin(
                        top: 22,
                      ),
                      textStyle: TextThemeHelper.bodyLargePrimaryContainer,
                      hintText: "Password".trTrans,
                      hintStyle: TextThemeHelper.bodyLargePrimaryContainer,
                      textInputType: TextInputType.visiblePassword,
                      obscureText: !_passwownVisible,
                      suffix: GestureDetector(
                        onTap: () {
                          setState(() {
                            _passwownVisible = !_passwownVisible;
                          });
                        },
                        child: Container(
                          margin: getMargin(
                            left: 5,
                            right: 14,
                          ),
                          child: CustomImageView(
                            svgPath: _passwownVisible
                                ? ImageConstant.eyeIcon
                                : ImageConstant.imgClosedEye,
                            color: AppColors.black,
                            height: 25.Sh,
                          ),
                        ),
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: getVerticalSize(
                          50,
                        ),
                      ),
                    ),
                    CustomElevatedButton(
                      width: getHorizontalSize(
                        360,
                      ),
                      height: getVerticalSize(
                        50,
                      ),
                      text: "Login".trTrans,
                      margin: getMargin(
                        top: 21,
                      ),
                      onTap: () {
                        _authViewModel.login(
                          emailController.text,
                          passwordController.text,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
