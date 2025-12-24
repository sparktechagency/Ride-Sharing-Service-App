import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart'; // Ensure correct path
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_images.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

class RiderPostSubmit extends StatelessWidget {
  const RiderPostSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller to trigger the final hit
    final controller = Get.find<PostRideController>();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back_ios, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          children: [
            const Spacer(),
            SizedBox(
              height: 264.h,
              width: double.infinity,
              child: Image.asset(AppImages.riderPost, fit: BoxFit.contain),
            ),
            SizedBox(height: 48.h),
            // Success Message
            Text(
              AppStrings.riderPostSubmit.tr,
              style: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 48.h),

            //=====================> Final Hit Button <=========================
            Obx(() => CustomButton(
              loading: controller.isPublishing.value, // Now the UI will listen to this change
              onTap: () {
                controller.publishRide();
              },
              text: AppStrings.postRides.tr,
            )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}