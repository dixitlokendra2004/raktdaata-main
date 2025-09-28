import 'dart:core';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/View_model/donor_view_model.dart';
import 'package:raktdata_app/presentation/widgets/custom_progress_bar.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import '../../NotificationServices/notificationServices.dart';
import '../../View_model/admin_view_model.dart';
import '../../View_model/auth_view_model_donor.dart';
import '../widgets/donor_card_widget.dart';

class DonorPendingHomePage extends StatefulWidget {
  const DonorPendingHomePage({super.key});

  @override
  State<DonorPendingHomePage> createState() => _DonorPendingHomePageState();
}

class _DonorPendingHomePageState extends State<DonorPendingHomePage> {
  NotificationServices notificationServices = NotificationServices();
  late AuthViewModel _authViewModel;
  late NeedViewModel _needViewModel;
  late DonorListViewModel _donorListViewModel;

  String currentUserId = " ";

  @override
  void initState() {
    super.initState();

    notificationServices.getDeviceToken().then((value) {
      _authViewModel.updateToken(value);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // try {
      currentUserId = _authViewModel.getCurrentUserDocId();
      await _needViewModel.fetchPendingData(currentUserId);
      // } catch (error) {
      //   print("Not successfull");
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModel>();
    _needViewModel = context.watch<NeedViewModel>();
    _donorListViewModel = context.watch<DonorListViewModel>();
    return Scaffold(
      body: CustomProgressBar(
        visibility: (_needViewModel.loading || _donorListViewModel.loading),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: _needViewModel.pendingDetails.length,
              padding: EdgeInsets.symmetric(horizontal: 10.Sw, vertical: 2.Sh),
              itemBuilder: (context, index) {
                return DonorCardWidget(
                  patientName: _needViewModel.pendingDetails[index].patientName,
                  disease: _needViewModel.pendingDetails[index].disease,
                  hospitalName:
                      _needViewModel.pendingDetails[index].hospitalName,
                  hospitalAddress:
                      _needViewModel.pendingDetails[index].hospitalAddress,
                  mobileNumber:
                      _needViewModel.pendingDetails[index].mobileNumber,
                  city: _needViewModel.pendingDetails[index].city,
                  bloodGroup: _needViewModel.pendingDetails[index].bloodGroup,
                  date: _needViewModel.pendingDetails[index].date,
                  // Assuming date is a DateTime object
                  bloodUnits: _needViewModel.pendingDetails[index].bloodUnits,
                  attendersName:
                      _needViewModel.pendingDetails[index].attendersName,
                  prescriptionUrl:
                      _needViewModel.pendingDetails[index].prescriptionUrl,
                  docId: _needViewModel.pendingDetails[index].docId,
                  isAccepted: false,
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
