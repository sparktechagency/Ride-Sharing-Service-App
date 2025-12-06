import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/utils.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_images.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

class RiderPostSubmit extends StatelessWidget {
  const RiderPostSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar:  AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          AppStrings.createRide.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Column(
        children: [
          Image.asset(AppImages.riderPost,width: 100.w,height: 100.h,),
          Spacer(),
          Text(AppStrings.riderPostSubmit.tr,style: TextStyle(color: AppColors.blackColor,fontSize: 16.sp),),
          SizedBox(height: 12.h,),
          CustomButton(onTap: (){}, text: AppStrings.submit.tr)
        ],
      ),

    );
  }
}