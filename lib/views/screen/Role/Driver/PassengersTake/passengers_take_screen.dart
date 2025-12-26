import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:intl/intl.dart'; // Add this to your pubspec.yaml for date formatting

import '../../../../base/custom_text.dart';
import '../rider_post_submit/rider_post_submit.dart';

class PassengersTakeScreen extends StatefulWidget {
  const PassengersTakeScreen({super.key});

  @override
  State<PassengersTakeScreen> createState() => _PassengersTakeScreenState();
}

class _PassengersTakeScreenState extends State<PassengersTakeScreen> {
  final controller = Get.find<PostRideController>();

  // Local state variables
  int passengerCount = 1;
  int priceCount = 1;
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            // 1. Sets the header, selection circle, and active day color
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            // 2. Explicitly sets the OK/CANCEL button text colors
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primaryColor, // Button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  //=======================> Passenger Methods <============================
  void increment() {
    setState(() {
      if (passengerCount < 10) passengerCount++;
    });
  }

  void decrement() {
    if (passengerCount > 1) {
      setState(() {
        passengerCount--;
      });
    }
  }

  //=======================> Price Methods <============================
  void incrementPrice() {
    setState(() {
      priceCount++;
    });
  }

  void decrementPrice() {
    if (priceCount > 1) {
      setState(() {
        priceCount--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final blueColor = const Color(0xFF00AEEF);

    return Scaffold(
      appBar:  CustomAppBar(title: 'Ride Details'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //=====================> Date Selection <=========================
            CustomText(
              text: "When are you going?".tr,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  // Optional: Change border color to primary when active
                  border: Border.all(color: AppColors.primaryColor.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    // Changed blueColor to your primaryColor for consistency
                    Icon(Icons.calendar_month, color: AppColors.primaryColor),
                    SizedBox(width: 12.w),
                    CustomText(
                      text: DateFormat('yyyy-MM-dd').format(selectedDate),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    const Spacer(),
                    // Changed edit icon to primary or keep grey for subtle look
                    Icon(Icons.edit, size: 18.sp, color: AppColors.primaryColor),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),

            //=====================> Passengers Count <=========================
            CustomText(
              text: AppStrings.howManyPassengers.tr,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pressButton(
                  Colors.blue.shade100,
                  const Icon(Icons.remove, color: Colors.white),
                  decrement,
                ),
                SizedBox(width: 36.w),
                CustomText(
                  text: passengerCount.toString(),
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 36.w),
                _pressButton(
                  blueColor,
                  const Icon(Icons.add, color: Colors.white),
                  increment,
                ),
              ],
            ),
            SizedBox(height: 32.h),

            //=====================> Price Count <=========================
            CustomText(
              text: AppStrings.setYourPricePerSeat.tr,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _pressButton(
                  Colors.blue.shade100,
                  const Icon(Icons.remove, color: Colors.white),
                  decrementPrice,
                ),
                SizedBox(width: 36.w),
                CustomText(
                  text: '\$$priceCount',
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(width: 36.w),
                _pressButton(
                  blueColor,
                  const Icon(Icons.add, color: Colors.white),
                  incrementPrice,
                ),
              ],
            ),

            //===================> Recommended Price  <==================
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: CustomText(
                  text: 'Recommended Price : \$1 - \$5',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 8.h),
            CustomText(
              text: AppStrings.perfectPriceForThisRide.tr,
              fontSize: 12.sp,
              maxLine: 2,
              textAlign: TextAlign.start,
              color: Colors.grey,
            ),

            const Spacer(),

            //===================> Submit button <==================
            CustomButton(
                onTap: () {
                  // 1. Save all local UI values to the controller
                  controller.availableSeats.value = passengerCount;
                  controller.estimatedPrice.value = priceCount.toDouble();
                  controller.selectedDate.value = selectedDate;

                  // 2. Just navigate to the next screen (Don't hit API yet)
                  Get.to(() => const RiderPostSubmit());
                },
                text: AppStrings.submit.tr
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  //=======================> Press Button Component <====================
  Widget _pressButton(Color color, Icon icon, VoidCallback method) {
    return GestureDetector(
      onTap: method,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        width: 48.w,
        height: 48.h,
        child: icon,
      ),
    );
  }
}