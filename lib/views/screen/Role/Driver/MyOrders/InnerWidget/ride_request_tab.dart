import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class RideRequestTab extends StatelessWidget {
  const RideRequestTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Expanded(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 3,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.borderColor,
                  ),
                ),
                child: Column(
                  children: [
                    //========================> Top Container <=================
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl:
                                'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                                height: 38.h,
                                width: 38.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Mr. Imran',
                                    bottom: 4.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(text: '4.9', right: 4.w),
                                      SvgPicture.asset(AppIcons.star),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    //========================> Details Container <=================
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: '\$15.99',
                            fontWeight: FontWeight.w600,
                            fontSize: 22.sp,
                            bottom: 8.h,
                          ),
                          Row(
                            children: [
                              CustomText(
                                text:
                                'Booking Time :'.tr,
                                fontWeight: FontWeight.w500,
                                bottom: 8.h,
                              ),
                              CustomText(
                                text:
                                'Sat 12 April 2025  8.30 PM',
                                fontWeight: FontWeight.w500,
                                left: 8.h,
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: AppStrings.pICKUP.tr,
                                    right: 4.w,
                                    bottom: 12.h,
                                  ),
                                  CustomText(text: 'Dhaka', right: 4.w),
                                ],
                              ),
                              SizedBox(
                                width: 102.w,
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.end,
                                children: [
                                  CustomText(
                                    text: AppStrings.dROPOFF.tr,
                                    left: 4.w,
                                    bottom: 12.h,
                                  ),
                                  CustomText(text: 'Rangpur', left: 4.w),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                              onTap: (){Get.toNamed(AppRoutes.rideDetailsScreen);},
                              width: 100.w,
                              height: 34.h,
                              text: AppStrings.accept.tr
                          ),
                          SizedBox(width: 8.w),
                          CustomButton(
                              onTap: (){Get.toNamed(AppRoutes.driverMessageScreen);},
                              width: 100.w,
                              height: 34.h,
                              text: AppStrings.cancel.tr,
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
