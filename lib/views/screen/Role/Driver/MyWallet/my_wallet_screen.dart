import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';



class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.myWallet.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //====================> Balance Container Row <==================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _balanceContainer('\$50000', AppStrings.totalBalance.tr),
                _balanceContainer('\$50000', AppStrings.totalWithdrawal.tr),
              ],
            ),
            SizedBox(height: 32.h),
            //====================> Transactions History <==================
            CustomText(
              text: AppStrings.transactionsHistory.tr,
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              maxLine: 3,
              bottom: 16.h,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(width: 1.w, color: AppColors.primaryColor),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //====================> Transactions Status <==================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: AppStrings.withdrawal.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                          maxLine: 3,
                        ),
                        CustomText(
                          text: 'Completed'.tr,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    //====================> Total amount <==================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Total Amount :'.tr,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          maxLine: 3,
                        ),
                        CustomText(
                          text: '\$100'.tr,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    SizedBox(height: 2.h),
                    Divider(thickness: 0.6, color: Colors.grey.shade200),
                    SizedBox(height: 2.h),
                    //====================> Total amount <==================
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Payment Date :'.tr,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.sp,
                          maxLine: 3,
                        ),
                        CustomText(
                          text: '12 jan 25 8.00AM'.tr,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 132.h),
            //====================> Withdraw balance Button <==================
            CustomButton(
              onTap: () {},
              text: AppStrings.withdrawBalance.tr,
            ),
          ],
        ),
      ),
    );
  }

  //========================> BalanceContainer Method <=============================
  _balanceContainer(String balance, title) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 173.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(width: 1.w, color: AppColors.primaryColor),
          ),
          child: Padding(
            padding: EdgeInsets.all(24.w),
            child: Column(
              children: [
                SvgPicture.asset(AppIcons.doller),
                SizedBox(height: 16.h),
                CustomText(
                  text: balance,
                  fontWeight: FontWeight.w600,
                  fontSize: 24.sp,
                  maxLine: 3,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 6.w,
          left: 6.w,
          bottom: -15.h,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              border: Border.all(width: 1.w, color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(21.r),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              child: CustomText(
                text: title,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
