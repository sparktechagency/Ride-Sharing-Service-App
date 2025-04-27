import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_icons.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_app_bar.dart';

class AddCityScreen extends StatelessWidget {
  AddCityScreen({super.key});

  List<String> cities = ['Dhaka', 'Rangpur', 'Sylhet'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //===========================> Add stopovers to get more passengers <=================
            CustomText(
              text: AppStrings.addStopoversToGetMorePassengers.tr,
              fontWeight: FontWeight.w500,
              fontSize: 18.sp,
              maxLine: 3,
              textAlign: TextAlign.start,
              bottom: 16.h,
            ),
            //================================> City Container <============================
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border(
                  top: BorderSide(width: 1.w, color: AppColors.borderColor),
                  left: BorderSide(width: 1.w, color: AppColors.borderColor),
                  right: BorderSide(width: 1.w, color: AppColors.borderColor),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(height: 16.h),
                  //=================================> City List View <==========================
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: cities.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(text: cities[index]),
                                SvgPicture.asset(AppIcons.cancel),
                              ],
                            ),
                            Divider(
                              thickness: 1.5,
                              color: AppColors.borderColor,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  //=================================> Add Button <==========================
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Center(
                        child: CustomText(
                          text: AppStrings.addCity.tr,
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            //================================> Next Button <============================
            CustomButton(
              onTap: () => _showPopup(context),
              text: AppStrings.next.tr,
            ),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }

  //================================> Show Popup Section <============================
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: SvgPicture.asset(AppIcons.cancel),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                //=============================> when are you going ? <====================
                CustomText(
                  text: AppStrings.whenAreYouGoing.tr,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                ),
                SizedBox(height: 16.h),
                //=============================> To From Location Container <====================
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardColor,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                CustomText(
                                  text: AppStrings.pICKUP,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: 'Dhaka',
                                  color: Colors.white,
                                  maxLine: 3,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        CustomText(
                          text: 'To',
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Column(
                              children: [
                                CustomText(
                                  text: AppStrings.pICKUP,
                                  fontWeight: FontWeight.bold,
                                ),
                                CustomText(
                                  text: 'Rangpur',
                                  maxLine: 3,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                //=================================> Timing <=========================
                Center(
                  child: CustomText(
                    text: 'Wed, Feb 12',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                Divider(thickness: 1.0, color: AppColors.borderColor),
                SizedBox(height: 12.h),
                Center(
                  child: CustomText(
                    text: '5.23 PM',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                //=============================> Next Button <====================
                SizedBox(height: 16.h),
                CustomButton(onTap: () {}, text: AppStrings.next.tr),
              ],
            ),
          ),
        );
      },
    );
  }
}
