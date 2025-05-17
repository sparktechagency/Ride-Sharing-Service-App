import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';

import '../../../../base/custom_text.dart';

class PassengersTakeScreen extends StatefulWidget {
  const PassengersTakeScreen({super.key});

  @override
  State<PassengersTakeScreen> createState() => _PassengersTakeScreenState();
}

class _PassengersTakeScreenState extends State<PassengersTakeScreen> {
  //=======================> Passenger Increment & Decrement Method <============================
  int passengerCount = 1;
  void increment() {
    setState(() {
      passengerCount++;
    });
  }

  void decrement() {
    if (passengerCount > 1) {
      setState(() {
        passengerCount--;
      });
    }
  }

  //=======================> Price Increment & Decrement Method <============================
  int priceCount = 1;
  void incrementPrice() {
    if (priceCount < 3) {
      setState(() {
        priceCount++;
      });
    }
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
    final blueColor = Color(0xFF00AEEF);
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //=====================> Passengers Count <=========================
            CustomText(
              text: AppStrings.howManyPassengers.tr,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              maxLine: 3,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //===================> Minus button <==================
                _pressButton(
                  Colors.blue.shade100,
                  Icon(Icons.remove, color: Colors.white, size: 24.w),
                  decrement,
                ),
                SizedBox(width: 36.w),
                //===================> Value <==================
                CustomText(
                  text: passengerCount.toString(),
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(width: 36),
                //===================> Plus button <==================
                _pressButton(
                  blueColor,
                  Icon(Icons.add, color: Colors.white, size: 24.w),
                  increment,
                ),
              ],
            ),
            SizedBox(height: 32.h),
            //=====================> Price Count <=========================
            CustomText(
              text: AppStrings.setYourPricePerSeat.tr,
              fontSize: 22.sp,
              fontWeight: FontWeight.w600,
              maxLine: 3,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 16.h),
            Divider(color: Colors.grey.shade300, thickness: 1),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //===================> Minus button <==================
                _pressButton(
                  Colors.blue.shade100,
                  Icon(Icons.remove, color: Colors.white, size: 24.w),
                  decrementPrice,
                ),
                SizedBox(width: 36.w),
                //===================> Value <==================
                CustomText(
                  text: '\$${priceCount.toString()}',
                  fontSize: 40.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                SizedBox(width: 36),
                //===================> Plus button <==================
                _pressButton(
                  blueColor,
                  Icon(Icons.add, color: Colors.white, size: 24.w),
                  incrementPrice,
                ),
              ],
            ),
            //===================> Recommended Price  <==================
            SizedBox(height: 24.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: CustomText(
                  text: 'Recommended Price : \$1 - \$3',
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              text: AppStrings.perfectPriceForThisRide.tr,
              fontSize: 12.sp,
              maxLine: 2,
              textAlign: TextAlign.start,
            ),
            //===================> Submit button <==================
            Spacer(),
            CustomButton(onTap: () {}, text: AppStrings.submit.tr),
            SizedBox(height: 48.h),
          ],
        ),
      ),
    );
  }

  //=======================> Press Button <====================
  _pressButton(Color color, Icon icon, VoidCallback method) {
    return GestureDetector(
      onTap: method,
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        width: 44,
        height: 44,
        child: icon,
      ),
    );
  }
}
