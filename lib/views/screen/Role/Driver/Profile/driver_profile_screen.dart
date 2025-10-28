import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_list_tile.dart';
import '../../../../base/custom_network_image.dart';
import '../../../../base/custom_text.dart';
import '../BottomNavBar/driver_bottom_menu..dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DriverBottomMenu(4),
      appBar: AppBar(
        title: CustomText(
          text: AppStrings.profile.tr,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
          child: Card(
            elevation: 5.5,
            shadowColor: AppColors.primaryColor,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
              child: Center(
                child: Column(
                  children: [
                    //====================> User Profile Image <====================
                    CustomNetworkImage(
                      imageUrl:
                          'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                      height: 135.h,
                      width: 135.w,
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    //=========================> User Name & Rating <========================
                    CustomText(
                      text: 'Bashar Islam',
                      fontWeight: FontWeight.w600,
                      fontSize: 20.sp,
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(text: '4.9'),
                        SizedBox(width: 8.w),
                        SvgPicture.asset(AppIcons.star),
                      ],
                    ),

                    SizedBox(height: 24.h),
                    //===================> Personal Information ListTile <=================
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.driverPersonalInformationScreen);
                      },
                      title: AppStrings.personalInformation.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.profile),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                    //===================> Rating ListTile <=================
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.ratingScreen);
                      },
                      title: AppStrings.rating.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.rating),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                    //===================> My Wallet ListTile <=================
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.myWalletScreen);
                      },
                      title: AppStrings.myWallet.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.myWallet),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                    //===================> My Ride ListTile <=================
                    CustomListTile(
                      onTap: () {
                       Get.toNamed(AppRoutes.driverMyRideScreen);
                      },
                      title: AppStrings.myRide.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.myRide),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                    //===================> Setting ListTile <=================
                    CustomListTile(
                      onTap: () {
                        Get.toNamed(AppRoutes.settingsScreen);
                      },
                      title: AppStrings.settings.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.setting),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                    //===================> Logout ListTile <=================
                    CustomListTile(
                      onTap: () {
                        _showCustomBottomSheet(context);
                      },
                      title: AppStrings.logout.tr,
                      prefixIcon: SvgPicture.asset(AppIcons.logout),
                      suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //===============================> Log Out Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
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
          height: 265,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Column(
            children: [
              SizedBox(
                width: 48.w,
                child: Divider(color: AppColors.greyColor, thickness: 5.5),
              ),
              SizedBox(height: 12.h),
              CustomText(
                text: 'Logout'.tr,
                fontWeight: FontWeight.w500,
                fontSize: 24.sp,
              ),
              SizedBox(
                width: 98.w,
                child: Divider(
                  thickness: 1,
                  color: AppColors.primaryColor,
                  indent: 15.w,
                ),
              ),
              SizedBox(height: 16.h),
              CustomText(
                text: 'Are you sure you want to log out?'.tr,
                fontSize: 16.sp,
              ),
              SizedBox(height: 48.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      Get.back();
                    },
                    text: "No".tr,
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  SizedBox(width: 16.w),
                  CustomButton(
                    width: 124.w,
                    height: 46.h,
                    onTap: () {
                      Get.offAllNamed(AppRoutes.signInScreen);
                    },
                    text: "Yes".tr,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
