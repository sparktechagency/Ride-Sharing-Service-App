import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/helpers/route.dart';

import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import 'booking_card.dart';

class CompletedTab extends StatelessWidget {
  const CompletedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.find();

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
      child: Obx(() {
        if (controller.isLoadingBooking.value) return const Center(child: CircularProgressIndicator());
        if (controller.bookings.isEmpty) return const Center(child: Text('No bookings found'));

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            final user = controller.userDetails.value;

            return BookingCard(
              booking: booking,
              from: booking.status.toLowerCase(), // 'completed', 'cancelled', or 'ongoing'
              onViewTap: () async {
                // Capture the specific booking data at the moment of tap
                // to prevent issues when the shared bookings list changes
                final bookingToNavigate = booking;

                // Fetch the specific user details for this booking's driver
                // to ensure we have the correct user data even if the shared state changes
                await controller.getBookingUserDetails(bookingToNavigate.driver.id);
                final userToNavigate = controller.userDetails.value;

                final result = await Get.toNamed(
                  AppRoutes.rideDetailsScreen,
                  arguments: {
                    'rideId': bookingToNavigate.id,
                    'driverId': bookingToNavigate.driver.id,
                    'booking': bookingToNavigate,
                    'user': userToNavigate, // Use the specific user details for this driver
                    'from': bookingToNavigate.status.toLowerCase()
                  },
                );

                if (result == true && bookingToNavigate.status.toLowerCase() == "ongoing") {
                  controller.getBookingsByStatus("ongoing");
                }
              },
              onChatTap: () {
                // Handle chat navigation
              },
            );
          },
        );
      }),
    );
  }
}
