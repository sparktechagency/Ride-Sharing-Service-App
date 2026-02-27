import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../../../controllers/driver_withdraw_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class DriverWithdrawScreen extends StatelessWidget {
  DriverWithdrawScreen({super.key});

  // Inject the new controller
  final DriverWithdrawController controller = Get.put(DriverWithdrawController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: "Make Payment".tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Please Information For The Withdrawal".tr,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                      bottom: 24.h,
                    ),
                    CustomTextField(
                      controller: controller.bankNameController,
                      hintText: "Bank Name".tr,
                      prefixIcon: Icon(Icons.account_balance, size: 20.sp),
                    ),
                    SizedBox(height: 16.h),
                    CustomTextField(
                      controller: controller.accountNumberController,
                      hintText: "Account Number".tr,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Icons.numbers_outlined, size: 20.sp),
                    ),
                    SizedBox(height: 16.h),

                        CustomTextField(
                          controller: controller.accountTypeController,
                          hintText: "Account Type".tr,
                          prefixIcon: Icon(Icons.credit_card, size: 20.sp),
                        ),
                        SizedBox(height: 16.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Withdrawal Amount".tr,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                        GestureDetector(
                          onTap: () => controller.setMaxAmount(),
                          child: CustomText(
                            text: "Balance: \$${controller.totalAvailableBalance.toStringAsFixed(2)} (Use Max)",
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: controller.amountController,
                      hintText: "Enter Amount".tr,
                      keyboardType: TextInputType.number,
                      prefixIcon: Icon(Icons.attach_money, size: 20.sp),
                      onChanged: (value) {
                        // Real-time check to prevent typing more than balance
                        double val = double.tryParse(value) ?? 0;
                        if (val > controller.totalAvailableBalance) {
                          controller.setMaxAmount();
                          Fluttertoast.showToast(msg: "Cannot exceed balance".tr);
                        }
                      },
                    ),

                    SizedBox(height: 40.h),
                  ],
                ),
              ),

              // Obx used to show loading state on the button
              Obx(() => CustomButton(
                onTap: controller.isLoading.value
                    ? () {}
                    : () => controller.requestWithdrawal(),
                text: controller.isLoading.value ? "Processing...".tr : "Withdraw".tr,
              )),
            ],
          ),
        ),
      ),
    );
  }
}