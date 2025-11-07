import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_button.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class CompletedOrderDetails extends StatelessWidget {
  const CompletedOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                                horizontal: 12.w, // Fixed: was .h
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
                              Flexible(
                                child: CustomText(
                                  text: AppStrings.pICKUP.tr,
                                  maxLine: 3,
                                  textAlign: TextAlign.start,
                                  bottom: 12.h,
                                ),
                              ),
                              SizedBox(
                                width: 16.w,
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              Flexible(
                                child: CustomText(
                                  text: AppStrings.dROPOFF.tr,
                                  textAlign: TextAlign.start,
                                  maxLine: 3,
                                  bottom: 12.h,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          //============================> Location Row <====================================
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomText(
                                  text: 'Dhaka',
                                  maxLine: 3,
                                  textAlign: TextAlign.start,
                                  bottom: 12.h,
                                ),
                              ),
                              Flexible(
                                child: CustomText(
                                  text: 'Rangpur',
                                  textAlign: TextAlign.start,
                                  maxLine: 3,
                                  bottom: 12.h,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          //============================> Total Passengers Row <====================================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: CustomText(
                                  text: 'Total Passengers Seat'.tr,
                                  textAlign: TextAlign.start,
                                  maxLine: 3,
                                  bottom: 12.h,
                                ),
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
                              Flexible(
                                child: CustomText(
                                  text: 'Booking Seat'.tr,
                                  textAlign: TextAlign.start,
                                  maxLine: 3,
                                ),
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
                              CustomText(
                                text: '0 seat',
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
                      width: double.infinity, // Fixed: was double.maxFinite
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
                          text: 'Completed Trip'.tr,
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
                ],
              ),
              SizedBox(height: 24.h),
              //==================================> Driver Details <===================
              ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: 12.h,
                    ),
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
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          text: 'Mr. Imran',
                                          bottom: 4.h,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        //=====================> Review & Star Row <=================
                                        Row(
                                          children: [
                                            CustomText(
                                              text: '4.9',
                                              fontSize: 18.sp,
                                              right: 4.w,
                                            ),
                                            SvgPicture.asset(AppIcons.star),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomText(
                                          text: 'Location: '.tr,
                                        ),
                                        CustomText(
                                          left: 4.w,
                                          text: 'Dhaka to Rangpur',
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
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CustomButton(
                              onTap: () {
                                _showReviewBottomSheet(context);
                              },
                              width: 84.w,
                              height: 34.h,
                              text: AppStrings.giveReview.tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the review bottom sheet
  void _showReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: MediaQuery.of(context).viewInsets.bottom > 0 ? 8.0 : 16.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(AppIcons.success),
              SizedBox(height: 8),
              CustomText(
                text: AppStrings.givePersonRating.tr,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              SizedBox(height: 16),
              //====================> Rating section <==========================
              RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                itemSize: 40,
                direction: Axis.horizontal,
                glowColor: Colors.red,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ),
              SizedBox(height: 16),
              // Text field for feedback
              TextField(
                decoration: InputDecoration(
                  hintText: 'Write your feedback'.tr,
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.h),
              //==============================> Buttons for Cancel and Submit <=========================
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 46.h,
                      color: Colors.white,
                      textColor: Colors.black,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      text: AppStrings.cancel.tr,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomButton(
                      height: 46.h,
                      onTap: () {
                        // TODO: Submit review logic
                        Navigator.pop(context);
                      },
                      text: AppStrings.submit.tr,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h)
            ],
          ),
        );
      },
    );
  }
}