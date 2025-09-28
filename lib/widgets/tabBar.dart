import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';

import '../core/app_colors.dart';
import '../presentation/donor_page/donor_accepted_homepage.dart';
import '../presentation/donor_page/donor_pending_homepage.dart';
import '../presentation/widgets/custom_drawer.dart';
import '../theme/text_theme_helper.dart';

class CustomTabBar extends StatefulWidget {
  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Donor".trTrans),
          iconTheme: IconThemeData(color: AppColors.white),
          backgroundColor: AppColors.Red700,
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(text: "Accepted".trTrans),
              Tab(text: "Pending".trTrans),
            ],
          ),
        ),
        drawer: CustomDrawer(donor: true),
        body: const TabBarView(
          children: [
            DonorAcceptedHomePage(),
            DonorPendingHomePage(),
          ],
        ),
      ),
    );
  }
}
