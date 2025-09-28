// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:raktdata_app/main.dart';
// import 'package:raktdata_app/presentation/donor_login_signUp/donor_signUp.dart';
// import 'package:raktdata_app/presentation/notificationScreen/notificationScreeen.dart';
//
// import '../presentation/donor_login_signUp/donor_login.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message)async {
// print('Title: ${message.notification?.title}');
// print('Body: ${message.notification?.body}');
// print('Payload: ${message.data}');
// }
//
// void handleMessage(RemoteMessage message){
//   if(message==null){
//     return;
//   }
//    Get.to(() => DonorSignUp());
//   //  navigatorKey.currentState?.pushNamed(NotificationScreen.route,arguments: message);
//
// }
//
//
// class FirebaseApi{
//
//   final _firebaseMessaging = FirebaseMessaging.instance;
//
//   Future initPushNotifications() async
//   {
//     await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     // FirebaseMessaging.instance.getInitialMessage().then(handleMessage );
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage );
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage );
//   }
//   Future<void> initNotifications() async{
//     await _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     print('token:$fCMToken');
//     // initPushNotifications();
//
//      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//   }
// }