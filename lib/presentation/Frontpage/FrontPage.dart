import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/core/app_export.dart';
import 'package:raktdata_app/widgets/custom_icon_button.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../../theme/text_theme_helper.dart';
import '../../widgets/custom_elevated_button.dart';
import '../adminPage/admin_login.dart';
import '../donor_page/donorChoosePage.dart';
import '../need_pages/signUp_requirement.dart';
import '../widgets/localization_checker.dart';
import 'package:http/http.dart' as http;

class FrontPage extends StatefulWidget {
  @override
  State<FrontPage> createState() => _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {
  void getData() async {
    CollectionReference collectionRef =
        FirebaseFirestore.instance.collection('Need');
    QuerySnapshot querySnapshot = await collectionRef.get();
    List<Object?> allData =
        querySnapshot.docs.map((doc) => doc.data()).toList();

    print(allData);
  }

  bool isLocaleFirst = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.Red700,
          // AppColors.deepRed,

          // Colors.red.shade700,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: getPadding(top: 35, left: 335),
              child: CustomIconButton(
                  child: CustomImageView(
                    imagePath: ImageConstant.language,
                    color: AppColors.white,
                    height: 35.Sh,
                    width: 35.Sw,
                  ),
                  onTap: () {
                    // if (isLocaleFirst) {
                    //   context.setLocale(context.supportedLocales[1]);
                    //         } else {
                    //        context.setLocale(context.supportedLocales[0]);
                    //      }
                    //      isLocaleFirst = !isLocaleFirst; // Toggle the flag
                    //      },
                    LocalizationChecker.changeLanguage(context);
                    setState(() {});
                  }),
            ), // SizedBox(height: 80,),
            Padding(
              padding: getPadding(top: 2, bottom: 5),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Shri Bijasan Maala Seva Mandal".trTrans,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextThemeHelper.titleBoldPrimaryContainer_3,
                      ),
                    ),
                    SizedBox(height: getVerticalSize(5)),
                    Center(
                      child: Text(
                        "Bijasan Mata Mandir,Indore".trTrans,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextThemeHelper.titleMediumPrimaryContainer_1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: getPadding(top: 10),
                child: Container(
                  width: double.maxFinite.Sw,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r))),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: getPadding(
                        top: 10,
                        left: 10,
                        right: 10,
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: getVerticalSize(10),
                          ),
                          CustomElevatedButton(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                gradient: LinearGradient(colors: [
                                  AppColors.Red300,
                                  AppColors.Red400,
                                  AppColors.Red600,
                                  AppColors.Red700,
                                ])),
                            height: 190.Sh,
                            width: 350.Sw,
                            margin: getMargin(top: 5),
                            onTap: () {
                              Get.to(() => DonorPage());
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
                            text: "Donor".trTrans,
                            // buttonTextStyle: ,
                            leftIcon: Container(
                              margin: getMargin(
                                left: 5,
                                right: 14,
                              ),
                              child: CustomImageView(
                                imagePath: ImageConstant.donateIcon2,
                                // donateIcon ,
                                color: AppColors.white,
                                height: 45.Sh,
                                width: 45.Sh,
                              ),
                            ),
                          ),

                          CustomElevatedButton(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                gradient: LinearGradient(colors: [
                                  AppColors.Red300,
                                  AppColors.Red400,
                                  AppColors.Red600,
                                  AppColors.Red700,
                                ])),
                            height: 190.Sh,
                            width: 350.Sw,
                            text: "Need".trTrans,
                            leftIcon: Icon(
                              Icons
                                  .bloodtype_outlined, // Replace with your desired person icon
                              size: 50.Sp, // Adjust the size as needed
                              color:
                                  AppColors.white, // Adjust the color as needed
                            ),
                            margin: getMargin(
                              top: 21,
                            ),
                            onTap: () {
                              Get.to(() => RequirementSignUp());
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
                          ),

                          CustomElevatedButton(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                // color:AppColors.deepRed,
                                gradient: LinearGradient(colors: [
                                  AppColors.Red300,
                                  AppColors.Red400,
                                  AppColors.Red600,
                                  AppColors.Red700,
                                ])),
                            height: 190.Sh,
                            width: 350.Sw,
                            text: "Admin".trTrans,
                            leftIcon: Icon(
                              Icons
                                  .person, // Replace with your desired person icon
                              size: 50.Sp, // Adjust the size as needed
                              color:
                                  AppColors.white, // Adjust the color as needed
                            ),
                            margin: getMargin(
                              top: 21,
                            ),
                            onTap: () {
                              getData();
                              Get.to(() => AdminLogin());
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
                          ),
                          // SizedBox(
                          //   height: 10.Sh,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  //  reloadPage() {
  //   setState(() {
  //     // This will trigger a rebuild of the UI
  //   });
  // }
}
