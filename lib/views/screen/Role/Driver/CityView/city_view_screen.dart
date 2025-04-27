import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

class CityViewScreen extends StatelessWidget {
  CityViewScreen({super.key});

  final List<Map<String, String>> items = [
    {'title': 'Dhaka', 'subtitle': 'Gabtoli Stand'},
    {'title': 'Mirpur', 'subtitle': 'Mirpur Doco C Block'},
    {'title': 'Rangpur', 'subtitle': 'Medical More Stand'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppStrings.theseAreTheBestPlaces.tr,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              maxLine: 2,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  bool isFirst = index == 0;
                  bool isLast = index == items.length - 1;
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: 2,
                                color:
                                    isFirst ? Colors.transparent : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 2,
                                color:
                                    isLast ? Colors.transparent : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index]['title'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                items[index]['subtitle'] ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton(onTap: () {}, text: AppStrings.next.tr),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
