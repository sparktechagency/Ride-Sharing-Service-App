import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/views/screen/Role/Driver/MyOrders/InnerWidget/ride_card.dart';

import '../../../../../../controllers/driver_status_ride_controller.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import '../widgets/no_data_widget.dart';

class CompletedTab extends StatelessWidget {
  CompletedTab({super.key}) {
    // Fetch data immediately when tab is accessed
    controller.fetchRidesByStatus("complete");
  }

  final controller = Get.find<DriverStatusRidesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingComplete.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: () => controller.fetchRidesByStatus("complete"),
        child: controller.completedRides.isEmpty
            ? const NoDataWidget(text: "No Complete orders found")
            : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          itemCount: controller.completedRides.length,
          itemBuilder: (context, index) {
            return RideCard(
              statusText: AppStrings.completed.tr,
              statusColor: Colors.green,
              ride: controller.completedRides[index],
            );
          },
        ),
      );


    });
  }
}
