import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

import 'package:intl/intl.dart';

class PendingTab extends StatelessWidget {
  const PendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Obx(() {
        if (controller.isLoadingBooking.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return const Center(child: Text('No bookings found'));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final statusBooking = controller.bookings[index];
            final userDetails = controller.userDetails.value;

            final formattedDate = DateFormat('EEE dd MMMM yyyy h.mm a')
                .format(DateTime.parse(statusBooking.rideDate))
                .toLowerCase();

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
                    /// TOP
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl:
                                "${ApiConstants.imageBaseUrl}${userDetails?.profileImage}",
                                height: 38.h,
                                width: 38.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: userDetails?.userName ?? '',
                                    bottom: 4.h,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        text: userDetails?.averageRating
                                            .toString() ??
                                            '0',
                                        right: 4.w,
                                      ),
                                      SvgPicture.asset(AppIcons.star),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),

                          /// STATUS
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.greyColor,
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 4.h,
                              ),
                              child: CustomText(
                                text: statusBooking.status.toUpperCase(),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Divider(
                      thickness: 1.5,
                      color: AppColors.borderColor,
                    ),

                    /// DETAILS
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: '\$${statusBooking.price}',
                            fontSize: 22.sp,
                            bottom: 8.h,
                          ),

                          Row(
                            children: [
                               CustomText(text: AppStrings.bookingTime.tr),
                              Expanded(
                                child: CustomText(
                                  text: formattedDate,
                                  left: 4.h,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 8.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: AppStrings.pICKUP.tr),
                                  CustomText(
                                      text: statusBooking.pickUp.address ?? ''),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(text: AppStrings.dROPOFF.tr),
                                  CustomText(
                                      text: statusBooking.dropOff.address ?? ''),
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
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.rideDetailsScreen,
                                  arguments: {
                                    'booking': statusBooking,
                                    'user': userDetails,
                                  },
                                );
                              },
                              width: 100.w,
                              height: 34.h,
                              text: AppStrings.view.tr),
                          SizedBox(width: 8.w),
                          // CustomButton(
                          //   onTap: () {},
                          //   width: 100.w,
                          //   height: 34.h,
                          //   text: AppStrings.chats.tr,
                          //   color: Colors.white,
                          //   textColor: Colors.black,
                          // ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
