import 'package:flutter/material.dart';

String ?mobileNumber;

bool mobileNumberValidator(String phoneNumber) {
  // Define a regular expression pattern for Indian phone numbers
  RegExp regex = RegExp(r'^[789]\d{9}$');

  // Use the hasMatch method to check if the input matches the pattern
  return regex.hasMatch(phoneNumber);
}
