import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/screen/Role/Driver/MyOrders/InnerWidget/single_ride_details_screen.dart';
import '../../../../../../models/driver_status_rides_response_model.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class RideCard extends StatelessWidget {
  final RideStaticsAttribute ride;
  final String statusText;
  final Color statusColor;
  final VoidCallback? onViewTap;

  const RideCard({
    super.key,
    required this.ride,
    required this.statusText,
    required this.statusColor,
    this.onViewTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1.w, color: AppColors.borderColor),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Column(
          children: [
            // ======================== Header with Price & Status ==================
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Total Fare',
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        text: '\$${ride.pricePerSeat ?? 0}',
                        fontWeight: FontWeight.w700,
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: statusColor, width: 1.w),
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    child: CustomText(
                      text: statusText,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ),

            // ======================== Route Information ==================
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  // Route line with icons
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Pickup icon and line
                      Column(
                        children: [
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.green,
                                width: 2.w,
                              ),
                            ),
                            child: Icon(
                              Icons.circle,
                              size: 8.w,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 40.h,
                            color: Colors.grey.shade300,
                            margin: EdgeInsets.symmetric(vertical: 4.h),
                          ),
                          Container(
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Colors.red,
                                width: 2.w,
                              ),
                            ),
                            child: Icon(
                              Icons.location_on,
                              size: 12.w,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: 12.w),

                      // Addresses
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Pickup address
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Pickup'.tr,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: ride.pickUp?.address ?? '',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  maxLine: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),

                            SizedBox(height: 24.h),

                            // Dropoff address
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Dropoff'.tr,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade600,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  text: ride.dropOff?.address ?? '',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  maxLine: 2,
                                  textOverflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // ======================== Booking Time ==================
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16.w,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(width: 8.w),
                            CustomText(
                              text: 'Booking Time'.tr,
                              fontSize: 12.sp,
                              color: Colors.grey.shade600,
                            ),
                          ],
                        ),
                        CustomText(
                          text: _formatDate(ride.createdAt),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // ======================== Footer with View Button ==================
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: AppColors.borderColor, width: 1.w),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    onTap: onViewTap ?? () {
                      if (ride.id != null && ride.id!.isNotEmpty) {
                        Get.to(() => SingleRideDetailsScreen(rideId: ride.id!));
                      }
                    },
                    width: 120.w,
                    height: 36.h,
                    text: AppStrings.view.tr,
                    textStyle: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Date formatter
  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return DateFormat('EEE dd MMM yyyy, hh:mm a').format(date);
  }
}