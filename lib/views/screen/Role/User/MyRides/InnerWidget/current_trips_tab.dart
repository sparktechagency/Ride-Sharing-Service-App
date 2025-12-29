import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import 'booking_card.dart';

class CurrentTripsTab extends StatelessWidget {
  const CurrentTripsTab({super.key});

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
              from: booking.status.toLowerCase(),
              onViewTap: () async {
                final result = await Get.toNamed(
                  AppRoutes.rideDetailsScreen,
                  arguments: {
                    'driverId': booking.driver.id,
                    'booking': booking,
                    'user': user, // Keep user for ride details screen if needed
                    'from': booking.status.toLowerCase()
                  },
                );

                if (result == true && booking.status.toLowerCase() == "ongoing") {
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

