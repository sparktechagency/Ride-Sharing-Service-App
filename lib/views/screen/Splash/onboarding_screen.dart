import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_images.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 181.h),
          Image.asset(AppImages.onboard, width: 404.w, height: 228.h),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                CustomText(
                  text: AppStrings.rideEasyArriveFastYour.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  maxLine: 5,
                ),
                SizedBox(height: 12.h),
                CustomText(
                  text: AppStrings.welcomeToRideSharingService.tr,
                  maxLine: 5,
                ),
                SizedBox(height: 32.h),
                CustomButton(onTap: () {Get.toNamed(AppRoutes.selectRoleScreen);}, text: AppStrings.getStarted.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
