import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/tabBar.dart';
import 'package:raktdata_app/widgets/util.dart';
import '../const/resource.dart';
import '../core/app_colors.dart';
import '../core/utils/user_utils.dart';
import '../presentation/Frontpage/FrontPage.dart';
import '../presentation/adminPage/adminPage.dart';
import '../presentation/donor_page/donor_EditDate.dart';
import '../presentation/donor_page/donor_accepted_homepage.dart';
import 'auth_helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    setState(() {
    });
    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isLoggedIn = AuthHelper.isLoggedIn();
    bool isAdmin = AuthHelper.isAdmin();
    if (isLoggedIn) {
      if (isAdmin) {
        Get.offAll(() => AdminPage());
      } else {
        Get.offAll(() =>CustomTabBar());
      }
    } else {
      Get.offAll(() => FrontPage());
    }
  }
  @override
  Widget build(BuildContext context) {
    Util.deviceHeight = MediaQuery.of(context).size.height;
    Util.deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Container(
          height: 250.Sh,
          width: 250.Sw,

          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/app_icon.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
