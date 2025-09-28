import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/presentation/adminPage/donor_list.dart';
import 'package:raktdata_app/widgets/change_last_donation_date.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:raktdata_app/widgets/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../View_model/auth_admin.dart';
import '../../core/utils/size_utils.dart';

class CustomDrawer extends StatelessWidget {
  bool donor;

  CustomDrawer({Key? key, this.donor = false}) : super(key: key);

  @override
  late AuthAdminViewModel _authViewModel;

  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthAdminViewModel>();

    return Drawer(
      // shadowColor: AppColors.deepRed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0.r), // Adjust the radius as needed
          // bottomRight: Radius.circular(20.0), // Adjust the radius as needed
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              AppColors.Red300,
              AppColors.Red400,
              AppColors.Red600,
              AppColors.Red700,
            ])), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                AppColors.Red300,
                AppColors.Red400,
                AppColors.Red600,
                AppColors.Red700,
              ])),
              accountName: Text(
                "Hello,".trTrans,
                style: TextStyle(fontSize: 18),
              ),
              accountEmail: Text(
                Util.user['name'] ?? "",
                style: TextStyle(
                  color: AppColors.white,
                ),
              ),
            ), //UserAccountDrawerHeader
          ),
          Visibility(
            visible: donor,
            child: Padding(
              padding: getPadding(left: 20.Sw, right: 20.Sw, top: 10.Sh),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month_rounded),
                iconColor: AppColors.black,
                horizontalTitleGap: 0,
                title: Text('Change Last Blood Donation Date'.trTrans),
                onTap: () {
                  Get.dialog(ChangeLastDonationDate());
                },
              ),
            ),
          ),
          Padding(
            padding: getPadding(left: 20.Sw, right: 20.Sw, top: 10.Sh),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.supervised_user_circle_outlined),
              iconColor: AppColors.black,
              horizontalTitleGap: 0,
              title: Text('Donors'.trTrans),
              onTap: () {
                Get.to(() => DonorListScreen());
              },
            ),
          ),
          Padding(
            padding: getPadding(left: 20.Sw, right: 20.Sw),
            // EdgeInsets.symmetric(horizontal: 40.0.Sw,vertical: 25.Sh),
            child: const Divider(
              thickness: 2,
              color: Color.fromARGB(255, 204, 204, 204),
            ),
          ),
          Padding(
            padding: getPadding(left: 20.Sw, right: 20.Sw),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.logout),
              iconColor: AppColors.black,
              horizontalTitleGap: 0,
              title: Text('LogOut'.trTrans),
              onTap: () {
                _authViewModel.signOut();
              },
            ),
          ),
        ],
      ),
    ); //Drawer
  }
}

Future<String> getUserEmail() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('email') ?? '';
}
