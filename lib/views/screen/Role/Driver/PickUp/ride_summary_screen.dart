import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/screen/Role/Driver/PickUp/set_passenger_price_screen.dart';

import '../../../../../controllers/post_rider_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../PassengersTake/passengers_take_screen.dart';

class RideSummaryScreen extends StatelessWidget {
  const RideSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the controller where all data is stored
    final controller = Get.find<PostRideController>();

    // 1. Logic Arrow: Combine Start -> Middle Cities -> End
    List<String> fullRoute = [
      controller.pickupAddress.value,
      ...controller.stopovers.map((s) => s.name),
      controller.destinationAddress.value,
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Confirm Route", style: TextStyle(color: Colors.black, fontSize: 18.sp)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
                "Trip Summary",
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: AppColors.primaryColor)
            ),
            Text(
              "Total Distance: ${controller.distanceText.value}",
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
            SizedBox(height: 30.h),

            // 2. The Visual Mapping List
            Expanded(
              child: ListView.builder(
                itemCount: fullRoute.length,
                itemBuilder: (context, index) {
                  bool isStart = index == 0;
                  bool isEnd = index == fullRoute.length - 1;

                  return IntrinsicHeight( // Ensures the vertical line connects perfectly
                    child: Row(
                      children: [
                        // Vertical Timeline Column
                        Column(
                          children: [
                            Icon(
                              isStart ? Icons.radio_button_checked : (isEnd ? Icons.location_on : Icons.circle),
                              color: isStart ? Colors.green : (isEnd ? Colors.red : AppColors.primaryColor),
                              size: 24.sp,
                            ),
                            if (!isEnd)
                              Expanded(
                                child: Container(
                                  width: 2.w,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(width: 20.w),
                        // Address Text Column
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                isStart ? "Pickup" : (isEnd ? "Drop-off" : "Stopover ${index}"),
                                style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                              ),
                              Text(
                                fullRoute[index],
                                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 25.h), // Spacing between stops
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // 3. Confirm & Move to Next Page
            Container(
              padding: EdgeInsets.only(bottom: 30.h),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                onPressed: () {
                  // Navigate to the screen where driver sets seats and price
                  Get.to(() => const PassengersTakeScreen());
                },
                child: Text(
                  "Next: Set Price & Seats",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}