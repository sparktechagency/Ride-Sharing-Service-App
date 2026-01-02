import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../controllers/wallet_details_controller.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_button.dart';
import '../../../../base/custom_text.dart';



class MyWalletScreen extends StatefulWidget {
  const MyWalletScreen({super.key});

  @override
  State<MyWalletScreen> createState() => _MyWalletScreenState();
}

class _MyWalletScreenState extends State<MyWalletScreen> {
  final WalletDetailsController walletController = Get.isRegistered<WalletDetailsController>()
      ? Get.find<WalletDetailsController>()
      : Get.put(WalletDetailsController(), permanent: true);

  @override
  void initState() {
    super.initState();
    walletController.fetchWalletDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.myWallet.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Obx(() {
          if (walletController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final wallet = walletController.getWalletSummary();
          final transactions = walletController.getTransactions();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //====================> Balance Container Row <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _balanceContainer(
                    '\$${wallet?.totalEarnings?.toStringAsFixed(2) ?? '0.00'}',
                    AppStrings.totalBalance.tr
                  ),
                  _balanceContainer(
                    '\$${wallet?.totalWithDrawal?.toStringAsFixed(2) ?? '0.00'}',
                    AppStrings.totalWithdrawal.tr
                  ),
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
              Expanded(
                child: transactions != null && transactions.isNotEmpty
                  ? ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(width: 1.w, color: AppColors.primaryColor),
                          ),
                          margin: EdgeInsets.only(bottom: 12.h),
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
                                      text: transaction.paymentType?.tr.capitalize ?? AppStrings.withdrawal.tr,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15.sp,
                                      maxLine: 3,
                                    ),
                                    CustomText(
                                      text: transaction.status?.toUpperCase() ?? 'N/A',
                                      color: transaction.status == 'completed'
                                          ? Colors.green
                                          : transaction.status == 'pending'
                                              ? Colors.orange
                                              : Colors.red,
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
                                      fontSize: 12.sp,
                                      maxLine: 3,
                                    ),
                                    CustomText(
                                      fontSize: 12.sp,
                                      text: '\$${transaction.totalAmount?.toStringAsFixed(2) ?? '0.00'}',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 2.h),
                                Divider(thickness: 0.6, color: Colors.grey.shade200),
                                SizedBox(height: 2.h),
                                //====================> Payment Date <==================
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      text: 'Payment Date :'.tr,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                      maxLine: 3,
                                    ),
                                    CustomText(
                                      fontSize: 12.sp,
                                      text: transaction.createdAt != null
                                          ? DateFormat('dd MMM yy h:mm a').format(transaction.createdAt!).toLowerCase()
                                          : 'N/A',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  :  Center(
                      child: CustomText(
                        text: 'No transactions found',
                        fontSize: 16.sp,
                      ),
                    ),
              ),
              SizedBox(height: 32.h),
              //====================> Withdraw balance Button <==================
              CustomButton(
                onTap: () {
                  // TODO: Implement withdraw functionality
                  // For now, keeping the same functionality as before
                },
                text: AppStrings.withdrawBalance.tr,
              ),
            ],
          );
        }),
      ),
    );
  }

  //========================> BalanceContainer Method <=============================
  _balanceContainer(String balance, String title) {
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
            child: Expanded(
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
