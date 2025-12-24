import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/post_rider_controller.dart';
import '../../../../../utils/app_colors.dart';

class SetPassengerPriceScreen extends StatelessWidget {
  const SetPassengerPriceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostRideController>();
    final priceEditController = TextEditingController(text: controller.estimatedPrice.value.toString());

    return Scaffold(
      appBar: AppBar(title: const Text("Finalize Ride")),
      body: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("How many passengers?", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),

            // --- SEAT SELECTOR ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _counterButton(Icons.remove, () {
                  if (controller.availableSeats.value > 1) controller.availableSeats.value--;
                }),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Obx(() => Text("${controller.availableSeats.value}", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold))),
                ),
                _counterButton(Icons.add, () {
                  if (controller.availableSeats.value < 10) controller.availableSeats.value++;
                }),
              ],
            ),

            SizedBox(height: 40.h),
            Text("Price per seat (BDT)", style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold)),
            SizedBox(height: 15.h),

            // --- PRICE INPUT (Type or Click) ---
            Row(
              children: [
                _counterButton(Icons.remove, () {
                  controller.estimatedPrice.value -= 10;
                  priceEditController.text = controller.estimatedPrice.value.toString();
                }),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: priceEditController,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    onChanged: (val) {
                      controller.estimatedPrice.value = double.tryParse(val) ?? 0.0;
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                _counterButton(Icons.add, () {
                  controller.estimatedPrice.value += 10;
                  priceEditController.text = controller.estimatedPrice.value.toString();
                }),
              ],
            ),

            const Spacer(),

            // --- PUBLISH BUTTON ---
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor),
                onPressed: () => controller.publishRide(),
                child: const Text("Publish Ride", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _counterButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Icon(icon, color: AppColors.primaryColor),
      ),
    );
  }
}