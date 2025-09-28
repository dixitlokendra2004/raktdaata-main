import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/app_string.dart';

class NeedModel {
  String docId; // Add a property to hold the document ID
  DateTime date;
  String patientName;
  String bloodGroup;
  String disease;
  String attendersName;
  String city;
  String mobileNumber;
  String hospitalName;
  String hospitalAddress;
  int bloodUnits;
  String prescriptionUrl;
  String token;
  String status;

  NeedModel({
    this.docId = AppStrings.NA, // Add docId to the constructor
    required this.date,
    this.patientName = AppStrings.NA,
    this.bloodGroup = AppStrings.NA,
    this.disease = AppStrings.NA,
    this.attendersName = AppStrings.NA,
    this.city = AppStrings.NA,
    this.mobileNumber = AppStrings.NA,
    this.hospitalName = AppStrings.NA,
    this.hospitalAddress = AppStrings.NA,
    this.bloodUnits = AppStrings.defaultNumber,
    this.prescriptionUrl = AppStrings.NA,
    this.token = AppStrings.NA,
    this.status = AppStrings.NA,
  });

  factory NeedModel.fromJson(Map<String, dynamic> json, String docId) {
    return NeedModel(
      docId: docId,
      date: (json['date'] as Timestamp).toDate(),
      // Convert Timestamp to DateTime
      patientName: json['patientName'] ?? AppStrings.NA,
      bloodGroup: json['bloodGroup'] ?? AppStrings.NA,
      disease: json['disease'] ?? AppStrings.NA,
      attendersName: json['attendersName'] ?? AppStrings.NA,
      city: json['city'] ?? AppStrings.NA,
      mobileNumber: json['mobileNumber'] ?? AppStrings.NA,
      hospitalName: json['hospitalName'] ?? AppStrings.NA,
      hospitalAddress: json['hospitalAddress'] ?? AppStrings.NA,
      bloodUnits: json['bloodUnits'] ?? AppStrings.defaultNumber,
      prescriptionUrl: json['prescriptionUrl'] ?? AppStrings.NA,
      token: json['status'] ?? AppStrings.NA,
      status: json['status'] ?? AppStrings.NA,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'docId': docId, //docId
      'date': date,
      'patientName': patientName,
      'bloodGroup': bloodGroup,
      'disease': disease,
      'attendersName': attendersName,
      'city': city,
      'mobileNumber': mobileNumber,
      'hospitalName': hospitalName,
      'hospitalAddress': hospitalAddress,
      'bloodUnits': bloodUnits,
      'prescriptionUrl': prescriptionUrl,
      'token': 'token',
      'status': 'status'
    };
  }
}

List<NeedModel> needModelList(String str) {
  List<dynamic> decodedList = json.decode(str);
  return List<NeedModel>.from(decodedList.map((x) {
    // Assuming x contains a 'docId' field
    return NeedModel.fromJson(x, x['docId']);
  }));
}

String categoryToJson(List<NeedModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
