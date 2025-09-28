import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/core/app_string.dart';
import 'package:raktdata_app/presentation/donor_login_signUp/donor_login.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';

import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../View_model/auth_view_model_donor.dart';
import '../../theme/app_decoration.dart';
import '../../theme/button_theme_helper.dart';
import '../../theme/text_theme_helper.dart';
import '../../theme/theme_helper.dart';
import '../../widgets/Custom_dropDown.dart';
import '../../widgets/Custom_textField_1.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_imageView.dart';
import '../../widgets/custom_textfrom_field.dart';
import '../../widgets/util.dart';
import '../widgets/custom_progress_bar.dart';

class DonorSignUp extends StatefulWidget {
  String newDocId;
  String phoneNo;

  DonorSignUp({
    Key? key,
    required this.newDocId,
    required this.phoneNo,
  }) : super(key: key);

  @override
  State<DonorSignUp> createState() => _DonorSignUpState();
}

class _DonorSignUpState extends State<DonorSignUp> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  late AuthViewModel _authViewModel;

  TextEditingController nameController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController cityController = TextEditingController();
  TextEditingController bloodGroupController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  String selectedBloodGroup = AppStrings.NA;
  DateTime? selectedDate = null;

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModel>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Register as Donor".trTrans,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextThemeHelper.titleBoldPrimaryContainer_3,
        ),
        backgroundColor: AppColors.Red700,
        centerTitle: true,
      ),
      body: Container(
        height: Util.deviceHeight,
        decoration: AppDecoration.getScreenBg,
        child: CustomProgressBar(
          visibility: _authViewModel.loading,
          child: Container(
            decoration: AppDecoration.getScreenBg,
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                padding: getPadding(
                  top: 10,
                ),
                child: Container(
                  margin: getMargin(
                    left: 7,
                  ),
                  child: Container(
                    padding: getPadding(
                      left: 10,
                      top: 3,
                      right: 10,
                      bottom: 3,
                    ),
                    decoration: AppDecoration.outline1.copyWith(
                      // color: Colors.blue,
                      borderRadius: BorderRadiusStyle.roundedBorder18,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: getMargin(
                            left: 1,
                            top: 9,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Name".trTrans,
                                controller: nameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                applyValidator: true,
                                // (name) => name!.length < 3 ? 'Name should be at least  3 characters long' : null,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "City".trTrans,
                                controller: cityController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              Padding(
                                padding: getPadding(top: 17),
                                child: CustomDropDown(
                                  variant:
                                      DropDownVariant.OutlineBluegray5002_1,
                                  title: "Blood Group".trTrans,
                                  items: const [
                                    'A+',
                                    'A-',
                                    'B+',
                                    'B-',
                                    'AB+',
                                    'AB-',
                                    'O+',
                                    'O-',
                                    'A1+',
                                    'A1-',
                                    'A2+',
                                    'A2-',
                                    'A1B+',
                                    'A1B-',
                                    'A2B+',
                                    'A2B-',
                                    'INRA',
                                  ],
                                  selectedItem: selectedBloodGroup,
                                  applyValidator: true,
                                  onChanged: (String bloodGroup) {
                                    setState(() {
                                      selectedBloodGroup = bloodGroup;
                                    });
                                  },
                                ),
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Last Blood Donation Date".trTrans,
                                controller: dateController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.datetime,
                                isDatePicker: true,
                                onDateSelected: (DateTime date) {
                                  selectedDate = date;
                                },
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Email".trTrans,
                                controller: emailController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomElevatedButton(
                                width: getHorizontalSize(
                                  360,
                                ),
                                height: getVerticalSize(
                                  50,
                                ),
                                margin: getMargin(
                                  top: 32,
                                ),
                                text: "Sign Up".trTrans,
                                onTap: () {
                                  _authViewModel.signUp(
                                    nameController.text,
                                    emailController.text,
                                    cityController.text,
                                    widget.phoneNo,
                                    selectedBloodGroup,
                                    selectedDate,
                                    widget.newDocId,
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
                                buttonTextStyle: TextThemeHelper
                                    .titleMediumNotoSansPrimaryContainer,
                              ),
                              // GestureDetector(
                              //   onTap: () {
                              //     Get.off(() => DonorLogin());
                              //   },
                              //   child: Container(
                              //     margin: getMargin(top: 50, bottom: 20),
                              //     child: Text(
                              //       "Already Registered? Login".trTrans,
                              //       overflow: TextOverflow.ellipsis,
                              //       textAlign: TextAlign.left,
                              //       style: TextThemeHelper.labelLargeNotoSans1,
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(height: 10.Sh,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
