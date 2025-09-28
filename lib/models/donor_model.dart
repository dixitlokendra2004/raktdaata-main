import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../core/app_string.dart';


List<DonorModel> needModelList(String str) => List<DonorModel>.from(
    json.decode(str).map((x) => DonorModel.fromJson(x)));

String categoryToJson(List<DonorModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class DonorModel {
   String name;
   String mobileNumber;
   String bloodGroup;
   List<String> pendingIds;
   List<String> acceptedIds;

  DonorModel(
      { this.name=AppStrings.NA,
        this.mobileNumber=AppStrings.NA,
        this.bloodGroup=AppStrings.NA,
        this.pendingIds= const [],
        this.acceptedIds= const [],
      }
      );

  factory DonorModel.fromJson(Map<String, dynamic> json) => DonorModel(
      name: json['name']?? AppStrings.NA,
      mobileNumber: json['mobileNumber'] ?? AppStrings.NA,
      bloodGroup: json['bloodGroup'] ?? AppStrings.NA,
    pendingIds: (json["pendingIds"] != null)
        ? List<String>.from(json["pendingIds"].map((x) => x))
        : [],
    acceptedIds: (json["acceptedIds"] != null)
        ? List<String>.from(json["acceptedIds"].map((x) => x))
        : [],

    );

  Map<String, dynamic> toJson() => {

    "name": name,
    "mobileNumber": mobileNumber,
    "bloodGroup":bloodGroup,
    "pendingIds": List<dynamic>.from(pendingIds.map((x) => x)),
    "acceptedIds": List<dynamic>.from(acceptedIds.map((x) => x)),

  };


}