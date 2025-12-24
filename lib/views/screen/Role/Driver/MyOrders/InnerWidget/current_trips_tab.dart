import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/screen/Role/Driver/MyOrders/InnerWidget/ride_card.dart';

import '../../../../../../controllers/driver_status_ride_controller.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import '../widgets/no_data_widget.dart';

class CurrentTripsTab extends StatelessWidget {
  CurrentTripsTab({super.key}) {
    // Fetch data immediately when tab is accessed
    controller.fetchRidesByStatus("open");
  }

  final controller = Get.find<DriverStatusRidesController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingOpen.value) {
        return const Center(child: CircularProgressIndicator());
      }



      return RefreshIndicator(
        onRefresh: () => controller.fetchRidesByStatus("open"),
        child: controller.openRides.isEmpty
            ? NoDataWidget(text: "No Current Trips orders found".tr)
            : ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
          itemCount: controller.openRides.length,
          itemBuilder: (context, index) {
            return RideCard(
              statusText: AppStrings.ongoing.tr,
              statusColor: AppColors.primaryColor,
              ride: controller.openRides[index],
            );
          },
        ),
      );


    });
  }
}
