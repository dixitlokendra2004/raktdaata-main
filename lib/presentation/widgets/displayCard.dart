import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/presentation/widgets/photo_view.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:raktdata_app/widgets/util.dart';
import '../../View_model/admin_view_model.dart';
import '../../View_model/donor_view_model.dart';
import '../../core/app_colors.dart';
import '../../core/utils/image_constant.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/text_theme_helper.dart';
import '../../widgets/custom_icon_button.dart';
import '../../widgets/custom_imageView.dart';

class DisplayCardWidget extends StatefulWidget {
  late String patientName;
  final String disease;
  final String hospitalName;
  final String hospitalAddress;
  final String mobileNumber;
  final String city;
  final String bloodGroup;
  final DateTime date; // Assume date is a DateTime object
  final int bloodUnits;
  final String attendersName;
  final String prescriptionUrl;
  String docId;

  DisplayCardWidget({
    required this.patientName,
    required this.disease,
    required this.hospitalName,
    required this.hospitalAddress,
    required this.mobileNumber,
    required this.city,
    required this.bloodGroup,
    required this.date,
    required this.bloodUnits,
    required this.attendersName,
    required this.prescriptionUrl,
    required this.docId,
  });

  @override
  State<DisplayCardWidget> createState() => _DisplayCardWidgetState();
}

class _DisplayCardWidgetState extends State<DisplayCardWidget> {
  late bool _isImagePopupOpen;
  bool accepted = false;

  late NeedViewModel _needViewModel;
  late DonorListViewModel _donorListViewModel;

  @override
  Widget build(BuildContext context) {
    _needViewModel = context.watch<NeedViewModel>();
    _donorListViewModel = context.watch<DonorListViewModel>();
    return Column(
      children: <Widget>[
        Card(
          margin: getMargin(top: 5, bottom: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
            side: BorderSide(
              color: AppColors.lightgrey.withOpacity(.2),
              width: 1.Sw,
            ),
          ),
          child: Container(
            // width: 400.Sw,
            // height: 370.Sh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: getPadding(left: 8, right: 8, top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: CustomImageView(
                          imagePath: ImageConstant.blood2,
                          color: AppColors.deepRed,
                          height: 40.Sh,
                          width: 40.Sw,
                        ),
                      ),
                      SizedBox(
                        width: 8.Sw,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: getPadding(top: 6),
                            // const EdgeInsets.fromLTRB(0, 6.0, 0, 0),
                            child: Text(
                              widget.patientName,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.left,
                              style: TextThemeHelper.titleBoldBlackContainer_4,
                              // style: TextStyle(
                              //   color: AppColors.black,
                              //   fontSize: getFontSize(20),
                              //   fontWeight: FontWeight.w600,
                              // ),
                            ),
                          ),
                          Text(
                            "${widget.bloodGroup} ${"Blood Group".trTrans}, ${widget.bloodUnits} ${"Units Needed".trTrans}",
                            // widget.bloodGroup + "," + widget.bloodUnits.toString(),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.left,
                            style: TextThemeHelper.labelLargeNotoSans1,
                            // style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: AppColors.black,
                  thickness: .2,
                  indent: 8,
                  endIndent: 8,
                ),
                Container(
                  child: Padding(
                    padding: getPadding(left: 8),
                    // EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Disease".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.disease,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10.Sh,
                        ),
                        Text(
                          "Hospital".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.hospitalName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10.Sh,
                        ),
                        Text(
                          "Hospital Address".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.hospitalAddress,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10.Sh,
                        ),
                        Text(
                          "City".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.city,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10.Sh,
                        ),
                        Text(
                          "Attender".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.attendersName,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10.Sh,
                        ),
                        Text(
                          "Mobile Number".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.mobileNumber,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Date".trTrans,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary1,
                        ),
                        Text(
                          widget.date.toString(),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextThemeHelper.montserratOnPrimary2,
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black,
                  thickness: .2,
                  indent: 8,
                  endIndent: 8,
                ),
                Container(
                  child: Padding(
                    padding: getPadding(left: 2, right: 2, top: 1, bottom: 1),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CustomIconButton(
                          child: CustomImageView(
                            svgPath: ImageConstant.eye,
                            color: AppColors.blue,
                            height: getSize(30),
                          ),
                          onTap: () {
                            // sendWhatsAppMessage();

                            Get.to(() => ZoomableImage(
                                imageUrl: widget.prescriptionUrl));
                            // Get.back();
                          },
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: getPadding(
                                    left: 2, right: 2, top: 1, bottom: 1),
                                // const EdgeInsets.fromLTRB(0, 0, 0, 2.0),
                                child: CustomIconButton(
                                  child: CustomImageView(
                                    svgPath: ImageConstant.tickCircle1,
                                    color: AppColors.lightGreen,
                                    height: getSize(30),
                                  ),
                                  onTap: () async {
                                    // to update status
                                    _needViewModel.setLoading(true);
                                    await _needViewModel.updateStatus(
                                        widget.docId, "Approved");
                                    //to send id in need list
                                    _needViewModel.sendNeedIdToDonors(
                                      widget.bloodGroup,
                                      widget.bloodUnits,
                                      widget.city,
                                      widget.docId,
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: 3),
                              Padding(
                                padding: getPadding(
                                    left: 2, right: 2, top: 1, bottom: 1),
                                child: CustomIconButton(
                                  child: CustomImageView(
                                    svgPath: ImageConstant.closeCircle,
                                    color: AppColors.deepRed,
                                    height: getSize(30),
                                  ),
                                  onTap: () {
                                    _needViewModel.deleteDocument(
                                        widget.docId, false);
                                    setState(() {});
                                    // Get.back();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
