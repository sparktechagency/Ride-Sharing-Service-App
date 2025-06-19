import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class RecentOrderScreen extends StatelessWidget {
  const RecentOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.recentOrderList.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                            //========================> Status Container <=================
                            CustomText(
                              text: '\$15.99',
                              fontWeight: FontWeight.w600,
                              fontSize: 22.sp,
                              color: AppColors.primaryColor,
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
                              text: 'Sat 12 April 2025  8.30 PM ',
                              fontWeight: FontWeight.w500,
                              bottom: 8.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.pICKUP.tr,
                                      bottom: 12.h,
                                    ),
                                    CustomText(text: 'Dhaka', bottom: 12.h),
                                    CustomText(text: 'Passenger'),
                                  ],
                                ),
                                SizedBox(
                                  width: 148.w,
                                  child: Divider(
                                    thickness: 1.5,
                                    color: AppColors.borderColor,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.dROPOFF.tr,
                                      bottom: 12.h,
                                    ),
                                    CustomText(text: 'Rangpur', bottom: 12.h),
                                    CustomText(text: '1 Passenger'),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5, color: AppColors.borderColor),
                      //========================> Accept & Cancel Button <=================
                      Padding(
                        padding: EdgeInsets.only(right: 16.w, bottom: 6.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomButton(
                              onTap: () {},
                              text: AppStrings.accept.tr,
                              width: 100.w,
                              height: 34.h,
                            ),
                            SizedBox(width: 8.w),
                            CustomButton(
                              onTap: () {},
                              text: AppStrings.cancel.tr,
                              width: 100.w,
                              height: 34.h,
                              color: Colors.white,
                              textColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
