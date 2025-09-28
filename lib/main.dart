import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:raktdata_app/foreground_notification.dart';
import 'package:raktdata_app/theme/theme_helper.dart';
import 'package:raktdata_app/widgets/config_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'NotificationServices/notificationServices.dart';
import 'core/app_string.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
NotificationServices notificationServices = NotificationServices();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  notificationServices.requestNotificationPermission();
  notificationServices.firebaseInit();
  notificationServices.setupInteractMessage();

  String theme = 'primary';

  ThemeHelper().changeTheme(theme);

  runApp(EasyLocalization(
    supportedLocales: [Locale('en', 'US'), Locale('hi', 'IN')],
    path: 'assets/translations',
    fallbackLocale: Locale('en', 'US'),
    startLocale: Locale('en', 'US'),
    child: ConfigScreen(),
  ));
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("OnbackgrounMessageReceived->");
  print(message.notification?.title.toString());
}
