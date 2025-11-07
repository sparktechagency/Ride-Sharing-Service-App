import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_images.dart';
import 'package:ride_sharing/views/base/custom_background.dart';
import '../../../helpers/prefs_helpers.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_constants.dart' show AppConstants;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   @override
  void initState() {
     Future.delayed(const Duration(seconds: 3), () async {
       final isLogged = await PrefsHelper.getBool(AppConstants.isLogged) ?? false;
       final userRole = await PrefsHelper.getString(AppConstants.userRole);
       if (isLogged) {
         if (userRole == 'driver') {
           Get.offAllNamed(AppRoutes.driverHomeScreen);
         } else if (userRole == 'user') {
           Get.offAllNamed(AppRoutes.userSearchScreen);
         } else {
           Get.offAllNamed(AppRoutes.onboardingScreen);
         }
       } else {
         Get.offAllNamed(AppRoutes.onboardingScreen);
       }
     });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appLogo,
          width: 149.w,
          height: 153.h,
        ),
      ),
    );
  }
}
