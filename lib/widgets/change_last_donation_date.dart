import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raktdata_app/core/app_export.dart';
import 'package:raktdata_app/widgets/Custom_textField_1.dart';
import 'package:raktdata_app/widgets/auth_helper.dart';
import 'package:raktdata_app/widgets/custom_elevated_button.dart';
import 'package:raktdata_app/widgets/extensions.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';
import 'package:raktdata_app/widgets/util.dart';

class ChangeLastDonationDate extends StatefulWidget {

  @override
  State<ChangeLastDonationDate> createState() => _ChangeLastDonationDateState();
}

class _ChangeLastDonationDateState extends State<ChangeLastDonationDate> {
  TextEditingController selectedDate = TextEditingController(text: Util.user['bloodDonationDate'].toString());

  @override
  void initState() {
    // try {
    // } catch(e) {}
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Dialog(
        backgroundColor: Colors.white,
        child: IntrinsicHeight(
          child: Container(
            padding: getPadding(all: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Change Last donation date",
                  style:
                      TextStyle(fontSize: 18.Sp, fontWeight: FontWeight.w600),
                ),
                Divider(
                  height: 20.Sh,
                  thickness: 1.Sh,
                ),
                CustomTextFormField_1(
                  variant: TextFormFieldVariant.OutlineBluegray5002_1,
                  fontStyle: TextFormFieldFontStyle.MontserratMedium16,
                  title: "Date".trTrans,
                  controller: selectedDate,
                  maxLines: 1,
                  margin: getMargin(top: 10),
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.text,
                  isDatePicker: true,
                  // onlyText: true,
                  applyValidator: true,
                ),
                CustomElevatedButton(
                  width: getHorizontalSize(360),
                  height: getVerticalSize(50),
                  text: "Save".trTrans,
                  margin: getMargin(top: 21),
                  onTap: () {
                    changeDate();
                  },
                  // 9755397694
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
    );
  }

  Future<void> changeDate() async {
    await FirebaseFirestore.instance
        .collection('donor')
        .doc(Util.user['docId'])
        .update({'bloodDonationDate': DateTime.parse(selectedDate.text)});
    await AuthHelper.saveDonorDataById(Util.user['docId']);
    Navigator.of(context).pop();
    Util.getSnackBar("Data Updated.", success: true);

  }
}
