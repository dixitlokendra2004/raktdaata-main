import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:raktdata_app/widgets/translate_extension.dart';

import '../../View_model/auth_view_model_donor.dart';
import '../../core/utils/size_utils.dart';
import '../../theme/app_decoration.dart';
import '../../theme/button_theme_helper.dart';
import '../../theme/text_theme_helper.dart';
import '../../widgets/Custom_textField_1.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/util.dart';

class DonorEditDatePage extends StatefulWidget {
  DonorEditDatePage({super.key});

  @override
  State<DonorEditDatePage> createState() => _DonorEditDatePageState();
}

class _DonorEditDatePageState extends State<DonorEditDatePage> {
  late AuthViewModel _authViewModel;

  TextEditingController dateController = TextEditingController();
  DateTime? selectedDate = null;
  late String uid;

  @override
  Widget build(BuildContext context) {
    _authViewModel = context.watch<AuthViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Donor".trTrans),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      // drawer: CustomDrawer(),
      body: Container(
        decoration: AppDecoration.getScreenBg,
        padding: Util.statusBarPadding(context),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: getPadding(
                  left: 10,
                  right: 10,
                ),
                child: CustomTextFormField_1(
                  variant: TextFormFieldVariant.OutlineBluegray5002_1,
                  fontStyle: TextFormFieldFontStyle.MontserratMedium16,
                  title: "Edit Last Blood Donation Date".trTrans,
                  controller: dateController,
                  maxLines: 1,
                  margin: getMargin(
                    top: 1,
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
              ),
              Padding(
                padding: getPadding(top: 30),
                child: CustomElevatedButton(
                  width: getHorizontalSize(
                    360,
                  ),
                  height: getVerticalSize(
                    50,
                  ),
                  text: "Edit".trTrans,
                  margin: getMargin(
                    top: 21,
                  ),
                  onTap: () {
                    _authViewModel.updateBloodDonationDate(
                      selectedDate,
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
                  buttonTextStyle:
                      TextThemeHelper.titleMediumNotoSansPrimaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
