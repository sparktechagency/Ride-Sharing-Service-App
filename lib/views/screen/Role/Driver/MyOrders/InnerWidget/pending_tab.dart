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
import '../widgets/no_data_widget.dart';

class PendingTab extends StatelessWidget {
  PendingTab({super.key}) {
    // Fetch data immediately when tab is accessed
    controller.fetchRidesByStatus("pending");
  }

  final controller = Get.find<DriverStatusRidesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingPending.value) {
        return const Center(child: CircularProgressIndicator());
      }

      return RefreshIndicator(
        onRefresh: () => controller.fetchRidesByStatus("pending"),
        child: controller.pendingRides.isEmpty
            ? NoDataWidget(text: "No pending orders found".tr)
            : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          itemCount: controller.pendingRides.length,
          itemBuilder: (context, index) {
            return RideCard(
              statusText: "Pending".tr,
              statusColor: Colors.orange,
              ride: controller.pendingRides[index],
            );
          },
        ),
      );
    });
  }
}
