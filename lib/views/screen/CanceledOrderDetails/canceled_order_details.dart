import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart' show AppStrings;
import '../../base/custom_app_bar.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class CanceledOrderDetails extends StatelessWidget {
  const CanceledOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                          //========================> Status Container <=================
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 4.h,
                              ),
                              child: CustomText(
                                text: AppStrings.cancel.tr,
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
                                  CustomText(
                                    text: AppStrings.passenger.tr,
                                    bottom: 12.h,
                                  ),
                                  CustomText(text: AppStrings.vehiclesType.tr),
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
                                  CustomText(text: '1 Passenger', bottom: 12.h),
                                  CustomText(text: 'Car'),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.ridePrice,
                            fontWeight: FontWeight.w500,
                          ),
                          CustomText(
                            text: '\$ 15.99',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp,
                            color: AppColors.primaryColor,
                            right: 24.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              //==================================> Driver Details <===================
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
                                Flexible(
                                  child: CustomText(
                                    text: AppStrings.details.tr,
                                    maxLine: 3,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
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
                          //=====================> Name & Image Row <=================
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
                          SizedBox(height: 24.h),
                          /*//=====================> Phone Number Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.call),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.phoneNumber.tr,
                                        ),
                                        CustomText(
                                          text: '(888) 4455-9999',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),*/
                          //=====================> Date of Birth Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.calender),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.dateOfBirth.tr,
                                        ),
                                        CustomText(
                                          text: '12/12/2000',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Location and Distance Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.location),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.location.tr,
                                        ),
                                        CustomText(
                                          text: 'Dhaka, Bangladesh',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Vehicles Type Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.type),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.vehiclesType.tr,
                                        ),
                                        CustomText(
                                          text: 'Car',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Reviews Section <=================
                          CustomText(
                            text: AppStrings.reviews.tr,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            bottom: 16.h,
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(
                                width: 1.w,
                                color: AppColors.borderColor,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomNetworkImage(
                                    imageUrl:
                                    'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                                    height: 38.h,
                                    width: 38.w,
                                    boxShape: BoxShape.circle,
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Mr. Imran',
                                          bottom: 4.h,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        CustomText(
                                          text: '12 jan 2025  8.45',
                                          fontWeight: FontWeight.w300,
                                          fontSize: 9.sp,
                                        ),
                                        Row(
                                          children: List.generate(
                                            5,
                                                (index) => const Icon(
                                              Icons.star,
                                              color: Colors.orange,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                        CustomText(
                                          text:
                                          'very helpful man and cool guy. very helpful man and cool guy. very helpful man and cool guy...',
                                          maxLine: 10,
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
