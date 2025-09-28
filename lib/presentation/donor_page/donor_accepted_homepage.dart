import 'dart:core';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import '../../NotificationServices/notificationServices.dart';
import '../../View_model/admin_view_model.dart';
import '../../View_model/auth_view_model_donor.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/text_theme_helper.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/displayCard.dart';
import '../widgets/donor_card_widget.dart';

class DonorAcceptedHomePage extends StatefulWidget {
  const DonorAcceptedHomePage({super.key});

  @override
  State<DonorAcceptedHomePage> createState() => _DonorAcceptedHomePageState();
}

class _DonorAcceptedHomePageState extends State<DonorAcceptedHomePage> {
  NotificationServices notificationServices = NotificationServices();
  late AuthViewModel _authViewModel;
  late NeedViewModel _needViewModel;

  String currentUserId = " ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    notificationServices.getDeviceToken().then((value) {
      _authViewModel.updateToken(value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        currentUserId = _authViewModel.getCurrentUserDocId();

        print("Fetching data...");
        await _needViewModel.fetchAcceptedData(currentUserId);
        // await _needViewModel.fetchPendingData(currentUserId);

        print("Data fetched successfully!");
        print("Fetched data:");
        print(_needViewModel.pendingDetails);
        print(_needViewModel.acceptedDetails);
      } catch (error) {
        print("888888888888888");
        print("Not successfull");
        // Handle error here (e.g., show a snackbar or log the error)
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModel>();
    _needViewModel = context.watch<NeedViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: _needViewModel.acceptedDetails.length,
              padding: EdgeInsets.symmetric(horizontal: 10.Sw, vertical: 2.Sh),
              itemBuilder: (context, index) {
                return DonorCardWidget(
                  patientName:
                      _needViewModel.acceptedDetails[index].patientName,
                  disease: _needViewModel.acceptedDetails[index].disease,
                  hospitalName:
                      _needViewModel.acceptedDetails[index].hospitalName,
                  hospitalAddress:
                      _needViewModel.acceptedDetails[index].hospitalAddress,
                  mobileNumber:
                      _needViewModel.acceptedDetails[index].mobileNumber,
                  city: _needViewModel.acceptedDetails[index].city,
                  bloodGroup: _needViewModel.acceptedDetails[index].bloodGroup,
                  date: _needViewModel.acceptedDetails[index].date,
                  // Assuming date is a DateTime object
                  bloodUnits: _needViewModel.acceptedDetails[index].bloodUnits,
                  attendersName:
                      _needViewModel.acceptedDetails[index].attendersName,
                  prescriptionUrl:
                      _needViewModel.acceptedDetails[index].prescriptionUrl,
                  docId: _needViewModel.acceptedDetails[index].docId,
                  isAccepted: true,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
