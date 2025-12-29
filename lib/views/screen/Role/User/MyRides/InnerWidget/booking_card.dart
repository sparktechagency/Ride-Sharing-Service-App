
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class BookingCard extends StatelessWidget {
  final dynamic booking;
  final dynamic user;
  final VoidCallback onViewTap;
  final VoidCallback? onChatTap;
  final String from;

  const BookingCard({
    super.key,
    required this.booking,
    required this.user,
    required this.onViewTap,
    this.onChatTap,
    required this.from,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return Colors.green;
      case 'cancelled':
        return const Color(0xffFF5050);
      default:
        return AppColors.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEE dd MMMM yyyy h.mm a')
        .format(DateTime.parse(booking.rideDate))
        .toLowerCase();

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1.w, color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 1,
            )
          ],
        ),
        child: Column(
          children: [
            /// TOP SECTION
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CustomNetworkImage(
                        imageUrl: "${ApiConstants.imageBaseUrl}${user?.profileImage}",
                        height: 38.h,
                        width: 38.w,
                        boxShape: BoxShape.circle,
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(text: user?.userName ?? '', fontWeight: FontWeight.bold),
                          Row(
                            children: [
                              CustomText(text: user?.averageRating.toString() ?? '0', right: 4.w, fontSize: 12.sp),
                              SvgPicture.asset(AppIcons.star, height: 12.h),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: _getStatusColor(booking.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: _getStatusColor(booking.status)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    child: Text(
                      booking.status.toUpperCase(),
                      style: TextStyle(
                        color: _getStatusColor(booking.status),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            /// PRICE & TIME
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(text: '\$${booking.price}', fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                  CustomText(text: formattedDate, fontSize: 12.sp, color: Colors.grey),
                ],
              ),
            ),

            /// LOCATION SECTION (Fixed Overflow using Vertical Timeline)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Icon(Icons.radio_button_off, color: Colors.green, size: 18.w),
                      Container(width: 1.5.w, height: 30.h, color: Colors.grey.shade300),
                      Icon(Icons.location_on, color: Colors.red, size: 18.w),
                    ],
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: booking.pickUp.address ?? '',
                          fontSize: 13.sp,
                          maxLine: 1,
                        ),
                        SizedBox(height: 22.h),
                        CustomText(
                          text: booking.dropOff.address ?? '',
                          fontSize: 13.sp,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const Divider(height: 1),

            /// BUTTONS SECTION
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (from == 'ongoing') ...[
                    CustomButton(
                      onTap: onChatTap ?? () {},
                      width: 90.w,
                      height: 34.h,
                      text: AppStrings.chats.tr,
                      color: Colors.white,
                      broderColor: AppColors.borderColor,
                      textColor: Colors.black,
                    ),
                    SizedBox(width: 8.w),
                  ],
                  CustomButton(
                    onTap: onViewTap,
                    width: 90.w,
                    height: 34.h,
                    text: AppStrings.view.tr,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}