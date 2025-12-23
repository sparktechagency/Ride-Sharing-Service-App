import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/screen/Role/Driver/MyOrders/InnerWidget/ride_card.dart';

import '../../../../../../controllers/driver_status_ride_controller.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class PendingTab extends StatelessWidget {
  PendingTab({super.key});

  final controller = Get.find<DriverStatusRidesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingPending.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
        itemCount: controller.pendingRides.length,
        itemBuilder: (context, index) {
          final ride = controller.pendingRides[index];

          return RideCard(
            statusText: AppStrings.canceled.tr,
            statusColor: const Color(0xffFF5050),
            ride: ride,
          );
        },
      );
    });
  }
}
