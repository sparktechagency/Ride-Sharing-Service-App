import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../../base/custom_text.dart';

class NoDataWidget extends StatelessWidget {
  final String text;
  const NoDataWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment_late_outlined, size: 60.sp, color: Colors.grey.shade300),
          SizedBox(height: 16.h),
          CustomText(
            text: text.tr,
            fontSize: 16.sp,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}