import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../base/custom_text.dart';

class GivenTab extends StatelessWidget {
  const GivenTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Expanded(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                //===================> Ratings and bars <====================
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      int starCount = 5 - index;
                      double value;
                      switch (starCount) {
                        case 5:
                          value = 1.0;
                          break;
                        case 4:
                          value = 0.8;
                          break;
                        case 3:
                          value = 0.6;
                          break;
                        case 2:
                          value = 0.4;
                          break;
                        case 1:
                        default:
                          value = 0.2;
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text(
                              '$starCount',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.star,
                              size: 16.w,
                              color: Colors.orange,
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 10.h,
                                  backgroundColor: Colors.orange.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(width: 16.w),
                //===================> Rating summary and stars <=====================
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                          text: '4.0',
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < 4 ? Icons.star : Icons.star_border,
                            size: 24,
                            color: Colors.orange,
                          );
                        }),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomText(
                            text: '52',
                            fontSize: 14.sp,
                          ),
                          CustomText(
                            left: 4.w,
                            text: 'Reviews'.tr,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
