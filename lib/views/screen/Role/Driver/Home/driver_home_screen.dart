import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../BottomNavBar/bottom_menu..dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(0),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AppImages.appLogo, width: 62.w, height: 52.h),
            Spacer(),
            InkWell(
              onTap: () {
                //Get.toNamed(AppRoutes.notificationsScreen);
              },
              child: SvgPicture.asset(AppIcons.notification),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 171.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(AppIcons.orderTR),
                            SizedBox(height: 12.h),
                            CustomText(
                              text: AppStrings.recentOrder.tr,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                            SizedBox(height: 12.h),
                            CustomText(
                              text: 'Total(12)'.tr,
                              fontWeight: FontWeight.w500,
                              fontSize: 18.sp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 24.h),
            CustomText(
              text: AppStrings.recentlyAcceptedOrder.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            )
          ],
        ),
      ),
    );
  }
}
