import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_images.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../../../controllers/localization_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_icons.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  LocalizationController localizationController = Get.find<LocalizationController>();
  final List<String> language = ['English', 'Spanish'];
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        selectedLanguage = language[localizationController.selectedIndex];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 48.h),
          //===========================> Language Dropdown Button <===================================
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 110.w,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: AppColors.fillColor,
                  borderRadius: BorderRadius.circular(16.r),
                  border:
                  Border.all(color: AppColors.primaryColor, width: 1),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    focusColor: Colors.white,
                    value: selectedLanguage ?? language[0],
                    dropdownColor: AppColors.whiteColor,
                    style: TextStyle(
                      color: AppColors.borderColor,
                      fontSize: 14.sp,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                    hint: CustomText(
                      text: 'Language'.tr,
                      fontSize: 16.sp,
                    ),
                    icon: SvgPicture.asset(
                      AppIcons.downArrow,
                      color: AppColors.primaryColor,
                    ),
                    isExpanded: true,
                    items: language.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: CustomText(
                          text: value,
                          fontSize: 16.sp,
                        ),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        int selectedIndex = language.indexOf(newValue);
                        if (selectedIndex != -1) {
                          Locale newLocale = Locale(
                            AppConstants
                                .languages[selectedIndex].languageCode,
                            AppConstants
                                .languages[selectedIndex].countryCode,
                          );
                          setState(() {
                            localizationController.setLanguage(newLocale);
                            selectedLanguage = language[selectedIndex];
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 132.h),
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
