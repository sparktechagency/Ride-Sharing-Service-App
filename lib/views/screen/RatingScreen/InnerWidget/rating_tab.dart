import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../models/get_rating_response_model.dart';
import '../../../base/custom_text.dart';


class RatingTab extends StatelessWidget {
  final RatingsAttributes attributes;

  const RatingTab({super.key, required this.attributes});

  @override
  Widget build(BuildContext context) {
    final breakdown = attributes.breakdown;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400, width: 1.w),
              borderRadius: BorderRadius.circular(8.r),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: List.generate(5, (index) {
                      final starCount = 5 - index;
                      final value = (breakdown[starCount.toString()] ?? 0) /
                          (attributes.totalRatings == 0
                              ? 1
                              : attributes.totalRatings);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Text(
                              '$starCount',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(Icons.star, size: 16.w, color: Colors.orange),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  value: value,
                                  minHeight: 10.h,
                                  backgroundColor: Colors.orange.shade100,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: attributes.averageRating.toString(),
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(5, (index) {
                          return Icon(
                            index < attributes.averageRating
                                ? Icons.star
                                : Icons.star_border,
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
                              text: attributes.totalRatings.toString(),
                              fontSize: 14.sp),
                          CustomText(
                            left: 4.w,
                            text: 'Reviews'.tr,
                            fontSize: 14.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}