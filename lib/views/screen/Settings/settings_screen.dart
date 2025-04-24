import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
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
}
