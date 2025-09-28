import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/View_model/auth_view_model_need.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/core/app_string.dart';
import 'package:raktdata_app/presentation/Frontpage/FrontPage.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/button_theme_helper.dart';
import '../../theme/text_theme_helper.dart';
import '../../widgets/Custom_dropDown.dart';
import '../../widgets/Custom_textField_1.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/util.dart';
import '../widgets/custom_progress_bar.dart';

class RequirementSignUp extends StatefulWidget {
  const RequirementSignUp({Key? key}) : super(key: key);

  @override
  State<RequirementSignUp> createState() => _RequirementSignUpState();
}

class _RequirementSignUpState extends State<RequirementSignUp> {
  var _scaffoldkey = GlobalKey<ScaffoldState>();

  late AuthViewModelNeed _authViewModel;

  TextEditingController patientNameController = TextEditingController();

  TextEditingController hospitalNameController = TextEditingController();

  TextEditingController hospitalAddressController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController attenderNameController = TextEditingController();

  TextEditingController diseaseController = TextEditingController();

  TextEditingController cityController = TextEditingController();

  TextEditingController mobileNumberController = TextEditingController();

  TextEditingController bloodGroupController = TextEditingController();

  TextEditingController bloodUnitController = TextEditingController();

  TextEditingController _fileNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _passwownVisible = false;
  bool _confirmPasswownVisible = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String selectedBloodGroup = AppStrings.NA;

  File? prescription = null; // Define a variable to store the picked file

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModelNeed>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Details to Register".trTrans,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.left,
          style: TextThemeHelper.titleBoldPrimaryContainer_3,
        ),
        backgroundColor: AppColors.Red700,
        // Colors.red.shade600 ,
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
                                title: "Patient's Name".trTrans,
                                controller: patientNameController,
                                maxLines: 1,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                // onlyText: true,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Disease".trTrans,
                                controller: diseaseController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Hospital's Name".trTrans,
                                controller: hospitalNameController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Hospital's Address".trTrans,
                                controller: hospitalAddressController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
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
                                  onChanged: (value) {
                                    setState(() {
                                      selectedBloodGroup = value;
                                    });
                                  },
                                ),
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Blood Units".trTrans,
                                controller: bloodUnitController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.number,
                                onlyNumber: true,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Attender's Name".trTrans,
                                controller: attenderNameController,
                                maxLines: 1,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.text,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),
                              CustomTextFormField_1(
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                title: "Mobile Number".trTrans,
                                prefix: Container(
                                  width: 3.Sw,
                                  // color: Colors.red,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: getPadding(left: 10),
                                    child: Text('+91'),
                                  ),
                                ),
                                controller: mobileNumberController,
                                maxLines: 1,
                                maxLength: 10,
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
                                textInputType: TextInputType.phone,
                                onlyNumber: true,
                                textInputAction: TextInputAction.next,
                                applyValidator: true,
                              ),

                              CustomTextFormField_1(
                                controller: _fileNameController,
                                variant:
                                    TextFormFieldVariant.OutlineBluegray5002_1,
                                shape: TextFormFieldShape.RoundedBorder12,
                                padding: TextFormFieldPadding.PaddingT13,
                                fontStyle:
                                    TextFormFieldFontStyle.MontserratMedium16,
                                // title: "Prescription".trTrans,
                                hintText:
                                    "Upload Prescription".trTrans,

                                maxLines: 1,
                                isFilePicker: true,
                                onFilePicked: (File file) {
                                  prescription = file;
                                },
                                onFileCanceled: () {
                                  setState(() {
                                    prescription =
                                        null; // Reset the pickedFile variable when the file is canceled
                                  });
                                },
                                margin: getMargin(
                                  top: 17,
                                  // bottom: 17,
                                ),
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
                                text: "Submit".trTrans,
                                onTap: () {
                                  print("1111111111111111111111111");
                                  if (prescription != null) {
                                    // Prescription file is selected, proceed with sign up
                                    _authViewModel.signUp(
                                      patientNameController.text,
                                      diseaseController.text,
                                      hospitalNameController.text,
                                      hospitalAddressController.text,
                                      mobileNumberController.text,
                                      cityController.text,
                                      selectedBloodGroup,
                                      bloodUnitController.text,
                                      attenderNameController.text,
                                      prescription!,
                                      // currentU,
                                    );
                                  } else {
                                    // Display a snackbar to inform the user
                                    Util.getSnackBar(
                                        'Please upload a prescription'.trTrans);
                                  }
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
                              Padding(
                                padding: getPadding(
                                  top: 50,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    Get.off(() => FrontPage());
                                  },
                                  child: Text(
                                    "Already Registered? HomePage".trTrans,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.left,
                                    style: TextThemeHelper.labelLargeNotoSans1,
                                  ),
                                ),
                              )
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
