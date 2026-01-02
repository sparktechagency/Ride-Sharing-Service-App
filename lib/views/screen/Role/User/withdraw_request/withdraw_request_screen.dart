import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../controllers/withdraw_request_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class WithdrawRequestScreen extends StatelessWidget {
  WithdrawRequestScreen({super.key});

  final WithdrawRequestController controller = Get.put(WithdrawRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: CustomAppBar(title: "Make Payment".tr),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: AppColors.borderColor, width: 1.w),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Please Information For The Withdrawal".tr,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      bottom: 24.h,
                      maxLine: 2,
                    ),

                    // Bank Name Field
                    CustomTextField(
                      controller: controller.bankNameController,
                      hintText: "Bank Name".tr,
                    ),
                    SizedBox(height: 16.h),

                    // Account Number Field
                    CustomTextField(
                      controller: controller.accountNumberController,
                      hintText: "Account Number".tr,
                      keyboardType: TextInputType.number,
                    ),
                    SizedBox(height: 16.h),

                    // Account Type Field (with Icon as per image)
                    CustomTextField(
                      controller: controller.accountTypeController,
                      hintText: "Account Type".tr,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Icon(Icons.credit_card, color: Colors.grey, size: 24.w),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Action Button
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Obx(() => CustomButton(
              onTap: () => controller.submitWithdrawRequest(),
              loading: controller.isLoading.value,
              text: "Withdraw Request".tr,
              width: double.infinity,
              height: 56.h,
            )),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}