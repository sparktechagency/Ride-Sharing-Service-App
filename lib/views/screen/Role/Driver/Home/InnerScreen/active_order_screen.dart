import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class ActiveOrderScreen extends StatelessWidget {
  const ActiveOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.activeOrders.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                text: AppStrings.ongoing.tr,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'Sat 12 April 2025  8.30 PM ',
                            fontWeight: FontWeight.w500,
                            maxLine: 2,
                            textAlign: TextAlign.start,
                            bottom: 8.h,
                          ),
                          Column(
                            children: [
                              //============================> Pickup And Drop of Row <====================================
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
                                    text: AppStrings.dROPOFF.tr,
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
                                      maxLine: 3),
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w, bottom: 6.h),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CustomButton(
                          onTap: () {
                            Get.toNamed(AppRoutes.activeOrderDetails);
                          },
                          text: AppStrings.view.tr,
                          width: 100.w,
                          height: 34.h,
                        ),
                      ),
                    ),
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
