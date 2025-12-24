import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../controllers/localization_controller.dart';
import '../../../helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_list_tile.dart';
import '../../base/custom_text.dart';
import '../../base/custom_text_field.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.settings.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              //=====================> Change Password List Tile <===================
              CustomListTile(
                onTap: () {
                 Get.toNamed(AppRoutes.changePasswordScreen);
                },
                title: AppStrings.changePassword.tr,
                prefixIcon: SvgPicture.asset(AppIcons.lock),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Privacy Policy  List Tile <===================
              CustomListTile(
                onTap: () {
                 Get.toNamed(AppRoutes.privacyPolicyScreen);
                },
                title: AppStrings.privacyPolicy.tr,
                prefixIcon: SvgPicture.asset(AppIcons.privacy),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Terms of Services List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.termsServicesScreen);
                },
                title: AppStrings.termsConditions.tr,
                prefixIcon: SvgPicture.asset(AppIcons.trems),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> About Us List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.aboutUsScreen);
                },
                title: AppStrings.aboutUs.tr,
                prefixIcon: SvgPicture.asset(AppIcons.about),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Language List Tile <===================
              CustomListTile(
                onTap: () {
                 _languageBottomSheet(context);
                },
                title: AppStrings.language.tr,
                prefixIcon: SvgPicture.asset(AppIcons.myRide),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
              //=====================> Delete Account List Tile <===================
              CustomListTile(
                onTap: () {
                  Get.toNamed(AppRoutes.supportScreen);
                },
                title: AppStrings.support.tr,
                prefixIcon: SvgPicture.asset(AppIcons.support),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
            ],
          ),
        ),
      ),
    );
  }
  //===============================> Language Bottom Sheet <===============================
  _languageBottomSheet(BuildContext context) {
    final LocalizationController localizationController = Get.find<LocalizationController>();

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: AppColors.cardColor,
          ),
          padding: EdgeInsets.all(16.w),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: AppStrings.language.tr,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.sp,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 20.h),
                Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                  indent: 15.w,
                ),
                SizedBox(height: 20.h),
                CustomText(
                  text: AppStrings.chooseYourLanguage.tr,
                  maxLine: 2,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 20.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                      width: 120.w,
                      onTap: () {
                        localizationController.setLanguage(const Locale('es', 'AR'));
                        if (kDebugMode) {
                          print('==============> Select Spanish Language');
                        }
                        Get.back();
                      },
                      text: "Spanish".tr,
                      color: Colors.white,
                      textColor: AppColors.primaryColor,
                    ),
                    SizedBox(width: 16.w),
                    CustomButton(
                        width: 120.w,
                        onTap: () {
                          localizationController.setLanguage(const Locale('en', 'US'));
                          if (kDebugMode) {
                            print('==============> Select English Language');
                          }
                          Get.back();
                        },
                        text: "English".tr
                    ),
                  ],
                ),
                SizedBox(height: 16.w),
              ],
            ),
          ),
        );
      },
    );
  }
}
