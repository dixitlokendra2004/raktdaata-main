// import 'dart:math';
//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:raktdata_app/core/app_colors.dart';
// import 'dart:io';
//
// import 'package:raktdata_app/core/app_export.dart';
// import 'package:raktdata_app/widgets/size_ext.dart';
//
// import '../../models/need_model.dart';
//
// class RequirementCard extends StatelessWidget {
//   String patientName;
//   String disease;
//   String hospitalName;
//   String mobileNumber;
//   String city;
//   String bloodGroup;
//   DateTime date; // Updated type to DateTime
//   String bloodUnits;
//   String attendersName;
//   String prescriptionUrl;
//   // File ?prescription;
//
//   // final String iconPath;
//   void Function(bool)? onChanged;
//
//   RequirementCard({
//     super.key,
//     // required this.iconPath,
//     // this.onChanged,
//     required this.patientName,
//     required this.disease,
//     required this.hospitalName,
//     required this.mobileNumber,
//     required this.city,
//     required this.bloodGroup,
//     required this.date,
//     required this.bloodUnits,
//     required this.attendersName,
//      required this.prescriptionUrl,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: getPadding(all: 15),
//       child: Container(
//
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(24),
//           color:AppColors.deepRedLight,
//           // powerOn ? Colors.grey[900] : Color.fromARGB(44, 164, 167, 189),
//         ),
//         child: Padding(
//           padding:  EdgeInsets.symmetric(vertical: 15.0.Sh),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // icon
//               // Image.asset(
//               //   iconPath,
//               //   height: 65,
//               //   color: powerOn ? Colors.white : Colors.grey.shade700,
//               // ),
//
//               // smart device name + switch
//               Row(
//                 children: [
//                   Expanded(
//                     child: Padding(
//                       padding: getPadding(left: 25),
//                       child: Column(
//                         children: [
//                           Text(
//                         patientName,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                             // style: TextStyle(
//                             //   fontWeight: FontWeight.bold,
//                             //   fontSize: 20,
//                             //   color:AppColors.white,
//                             //   // powerOn ? Colors.white : Colors.black,
//                             // ),
//                           ),
//                           // Text(
//                           //   "",
//                           //   style: TextStyle(
//                           //     fontWeight: FontWeight.bold,
//                           //     fontSize: 20,
//                           //     color:AppColors.white,
//                           //     // powerOn ? Colors.white : Colors.black,
//                           //     ),
//                           // ),
//                           Text(
//                             disease,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             hospitalName,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             mobileNumber,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             city,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             bloodGroup,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             date.toString(),
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             bloodUnits,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           Text(
//                             attendersName,
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: TextThemeHelper.labelLargeNotoSans,
//                           ),
//                           // Text(
//                           //   prescription,
//                           //   style: TextStyle(
//                           //     fontWeight: FontWeight.bold,
//                           //     fontSize: 20,
//                           //     color:AppColors.white,
//                           //     // powerOn ? Colors.white : Colors.black,
//                           //   ),
//                           // ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }