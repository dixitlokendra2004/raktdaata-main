import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raktdata_app/core/app_colors.dart';
import 'package:raktdata_app/widgets/size_ext.dart';
import 'package:http/http.dart' as http;
import '../core/app_string.dart';

const USER_INVALID_RESPONSE = 100;
const NO_INTERNET = 101;
const INVALID_FORMAT = 102;
const UNKNOWN_ERROR = 103;
const UNAUTHORISED = 401;

class Util {
  static var mockupHeight = 812;
  static var mockupWidth = 375;
  static var deviceHeight;
  static var deviceWidth;

  static Map get user => (GetStorage().read('user') as Map?) ?? {};

  static Future<void> sendFCMNotification(
      List<String> registrationTokens, String title, String body) async {
    print("sendFCMNotification to $registrationTokens");
    print("title $title");
    print("body $body");
    final String serverKey =
        'AAAA678cbE4:APA91bEGxHyeQlegW_cdeYc9f8N5b_isMWYg4ysucR4-Hp7bZYM_pckKXqcHFykbbJwo2Q0NuXrXXuOmAD3cnEVsRXi4WGbk0T_G0ly4kzoAikSZKXLPfbxCMJOMy_zpYNt3fl3wGjco';
    final String fcmUrl = 'https://fcm.googleapis.com/fcm/send';
    int retryCount = 0;

    while (retryCount < 3) {
      try {
        final Map<String, dynamic> data = {
          'registration_ids': registrationTokens,
          'notification': {
            'title': title,
            'body': body,
          },
        };

        final response = await http.post(
          Uri.parse(fcmUrl),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'key=$serverKey',
          },
          body: jsonEncode(data),
        );

        if (response.statusCode == 200) {
          print('Notification sent successfully.');
          return;
        } else {
          print('Failed to send notification: ${response.body}');
        }
      } catch (e) {
        print('Error occurred while sending notification: $e');
      }
      retryCount++;
    }

    print('Notification sending failed after 3 attempts.');
  }

  static getSnackBar(String text,
      {var icon, color, int duration = 3, bool success = false}) {
    if (!Get.isSnackbarOpen) {
      Get.showSnackbar(
        GetSnackBar(
          messageText: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(right: 10.Sw),
                  child: Icon(
                      success
                          ? Icons.check_circle_outline_rounded
                          : icon ?? Icons.info_outline_rounded,
                      color: Colors.white,
                      size: 22.Sh)),
              Expanded(
                child: Text(
                  text,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.Sp,
                  ),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.fromLTRB(20.Sw, 0, 20.Sw, 20.Sh),
          padding: EdgeInsets.symmetric(vertical: 20.Sh, horizontal: 20.Sw),
          borderRadius: 13.r,
          maxWidth: 600,
          backgroundColor:
              success ? Colors.green : color ?? Color.fromRGBO(238, 82, 95, 1),
          duration: Duration(seconds: duration),
        ),
      );
    }
  }

  static parseDateTime(dynamic dateTimeIst, {bool changeToIst = true}) {
    if (dateTimeIst == null) return AppStrings.NA;
    if ((DateTime.tryParse(dateTimeIst) ?? AppStrings.NA) is DateTime) {
      if (changeToIst) {
        var d = DateTime.parse(dateTimeIst);
        return d;
      } else {
        return DateTime.parse(dateTimeIst);
      }
    } else {
      return AppStrings.NA;
    }
  }

  static double getHeight(var height) {
    var percent = ((height / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getWidth(var width) {
    var percent = ((width / mockupWidth) * 100);
    return ((deviceWidth * percent) / 100);
  }

  static double getSp(var sp) {
    var percent = (((sp - 0.25) / mockupHeight) * 100);
    return ((deviceHeight * percent) / 100);
  }

  static double getRadius(var radius) {
    return double.parse(radius.toString());
  }

  static printString(var v) {
    print(v);
  }

  static printLog(var v) {
    log(v);
  }

  static double parseDouble(value, {int? pointValue}) {
    double result = AppStrings.defaultDouble;
    if (value is num) {
      result = value.toDouble();
    } else if (value is String) {
      result = double.tryParse(value) ?? AppStrings.defaultDouble;
    }
    if (pointValue != null) {
      return double.parse(result.toStringAsFixed(2));
    } else {
      return result;
    }
  }

  static statusBarPadding(context) {
    return EdgeInsets.only(top: MediaQuery.of(context).padding.top);
  }

  static showToast(String message) {
    getSnackBar(message, color: AppColors.blue);
    // Fluttertoast.showToast(
    //   msg: message,
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 3,
    //   backgroundColor: Colors.grey,
    //   textColor: Colors.white,
    // );
  }
}
