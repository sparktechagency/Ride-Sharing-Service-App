import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class ActiveOrderDetails extends StatelessWidget {
  const ActiveOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.details.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //==================================> Ride Details <===================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    //========================> Top Container <=================
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                SvgPicture.asset(AppIcons.bgCalander),
                                SizedBox(width: 8.w),
                                Flexible(
                                  child: CustomText(
                                    text: 'Sat 12 April 2025 8.30 PM',
                                    maxLine: 3,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 4.h,
                              ),
                              child: CustomText(
                                text: AppStrings.completed.tr,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    //========================> Details Container <=================
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        children: [
                          //============================> Pickup and Drop Row <====================================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.pICKUP.tr,
                                maxLine: 3,
                                textAlign: TextAlign.start,
                                bottom: 12.h,
                              ),
                              SizedBox(
                                width: 148.w,
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              CustomText(
                                text: AppStrings.pICKUP.tr,
                                textAlign: TextAlign.start,
                                maxLine: 3,
                                bottom: 12.h,
                              ),
                            ],
                          ),
                          //============================> Location Row <====================================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Dhaka',
                                maxLine: 3,
                                textAlign: TextAlign.start,
                                bottom: 12.h,
                              ),
                              CustomText(
                                text: 'Rangpur',
                                textAlign: TextAlign.start,
                                maxLine: 3,
                                bottom: 12.h,
                              ),
                            ],
                          ),
                          //============================> Total Passengers Row <====================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                    text: 'Total Passengers Seat'.tr,
                                    textAlign: TextAlign.start,
                                    maxLine: 3,
                                    bottom: 12.h),
                              ),
                              Spacer(),
                              CustomText(
                                  text: '20',
                                  textAlign: TextAlign.start,
                                  right: 4.w,
                                  maxLine: 3),
                              CustomText(
                                  text: 'Passenger'.tr,
                                  textAlign: TextAlign.start,
                                  maxLine: 3),
                            ],
                          ),
                          //============================> Booking Seat Row <====================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Booking Seat'.tr,
                                textAlign: TextAlign.start,
                                maxLine: 3,
                              ),
                              Spacer(),
                              CustomText(
                                  text: '08',
                                  textAlign: TextAlign.start,
                                  right: 4.w,
                                  maxLine: 3),
                              CustomText(
                                  text: 'Passenger'.tr,
                                  textAlign: TextAlign.start,
                                  maxLine: 3),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.availableSeat.tr,
                                fontWeight: FontWeight.w500,
                              ),
                              Spacer(),
                              CustomText(
                                text: '12 ',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                              CustomText(
                                text: 'seats'.tr,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: AppStrings.ridePrice.tr,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: '\$ 15.99',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //========================> Completed Trip Container <=================
                    Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16.r),
                          bottomRight: Radius.circular(16.r),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: CustomText(
                          text: 'Star Trip'.tr,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              //==================================> Total User And See All Button Row <===================
              Row(
                children: [
                  CustomText(
                    text: AppStrings.totalUser.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    right: 4.w,
                  ),
                  CustomText(
                    text: '(8)',
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.totalUserScreen);
                    },
                    child: CustomText(
                      text: AppStrings.seeAll.tr,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              //==================================> Driver Details <===================
              SizedBox(
                height: 320.h,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //=====================> Name & Image Row <=================
                            Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl:
                                      'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                                  height: 54.h,
                                  width: 54.w,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: 'Mr. Imran',
                                      bottom: 4.h,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    CustomText(text: 'Location: '.tr),
                                    CustomText(text: 'Dhaka to Rangpur'),
                                  ],
                                ),
                                Spacer(),
                                //=====================> Review & Star Row <=================
                                Row(
                                  children: [
                                    CustomText(text: '4.9', fontSize: 18.sp),
                                    SvgPicture.asset(AppIcons.star),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
