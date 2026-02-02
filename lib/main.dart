import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/themes/light_theme.dart';
import 'package:ride_sharing/utils/app_constants.dart';
import 'package:ride_sharing/utils/message.dart';
import 'controllers/localization_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart';
import 'helpers/di.dart' as di;
import 'helpers/notification_helpers.dart';
import 'helpers/route.dart';
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //===========================> Generate to FCM Token <============================
   try {
    if (GetPlatform.isMobile) {
      final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
      if (remoteMessage != null) {
      }
      await NotificationHelper.init(flutterLocalNotificationsPlugin);
      FirebaseMessaging.onBackgroundMessage(NotificationHelper.firebaseMessagingBackgroundHandler);
    }
  }catch(e) {}
  NotificationHelper.getFcmToken();
  Map<String, Map<String, String>> languages = await di.init();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetBuilder<LocalizationController>(
          builder: (localizeController) {
            return ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return GetMaterialApp(
                  title: AppConstants.APP_NAME,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  theme: light(),
                  defaultTransition: Transition.topLevel,
                  locale: localizeController.locale,
                  translations: Messages(languages: languages),
                  fallbackLocale: Locale(
                    AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode,
                  ),
                  transitionDuration: const Duration(milliseconds: 500),
                  getPages: AppRoutes.page,
                  initialRoute: AppRoutes.splashScreen,
                );
              },
            );
          },
        );
      },
    );
  }
}
