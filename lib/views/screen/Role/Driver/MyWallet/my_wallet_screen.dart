import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/helpers/route.dart';
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
              SizedBox(height: 20.h),
              //====================> Balance Cards Row <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _balanceContainer(
                      '\$${wallet?.totalEarnings?.toInt() ?? '0'}',
                      AppStrings.totalBalance.tr
                  ),
                  _balanceContainer(
                      '\$${wallet?.totalWithDrawal?.toInt() ?? '0'}',
                      AppStrings.totalWithdrawal.tr
                  ),
                ],
              ),

              SizedBox(height: 50.h), // Extra space for the overlapping labels

              //====================> Withdraw Button (Moved Up) <==================
              CustomButton(
                onTap: () {
                  final balance = walletController.getWalletSummary()?.totalEarnings ?? 0.0;

                  // Use .then() to catch the event when the user comes back
                  Get.toNamed(AppRoutes.driverWithdrawScreen, arguments: balance)?.then((value) {
                    walletController.fetchWalletDetails();
                  });
                },
                text: AppStrings.withdrawBalance.tr,
              ),

              SizedBox(height: 32.h),

              //====================> Transactions History Title <==================
              CustomText(
                text: AppStrings.transactionsHistory.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
                bottom: 16.h,
              ),

              //====================> Transactions List <==================
              Expanded(
                child: transactions != null && transactions.isNotEmpty
                    ? ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    return _transactionCard(transaction);
                  },
                )
                    : Center(child: CustomText(text: 'No transactions found')),
              ),
            ],
          );
        }),
      ),
    );
  }

  //========================> Updated Balance Container <=============================
  Widget _balanceContainer(String balance, String title) {
    return Stack(
      alignment: Alignment.bottomCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 160.w,
          height: 180.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(width: 1.w, color: Colors.grey.shade400),
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
        // Overlapping Blue Label
        Positioned(
          bottom: -18.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFF00ADEE),
              borderRadius: BorderRadius.circular(25.r),
            ),
            child: CustomText(
              text: title,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

//========================> Transaction Item UI <=============================
  Widget _transactionCard(dynamic transaction) {
    // Get status from response, default to 'Pending' if null
    String status = (transaction.status ?? 'pending').toLowerCase();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1.w, color: Colors.grey.shade300),
      ),
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 1. Give the left side a fixed or flexible space
              CustomText(
                  text: "Withdrawal",
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp
              ),
              SizedBox(width: 8.w), // Small gap to prevent text touching

              // 2. Wrap the right side in Expanded to prevent overflow
              Expanded(
                child: RichText(
                  textAlign: TextAlign.end, // Keeps text aligned to the right
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${status.capitalizeFirst}: ",
                        style: TextStyle(
                          color: _getStatusColor(status),
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextSpan(
                        text: "\$${transaction.totalAmount?.toInt() ?? '0'}",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                  text: "Date :",
                  color: Colors.grey.shade700,
                  fontSize: 14.sp
              ),
              CustomText(
                text: transaction.createdAt != null
                    ? DateFormat('dd MMM yy h:mm a').format(transaction.createdAt!)
                    : 'N/A',
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to get color based on response status
  Color _getStatusColor(String status) {
    switch (status) {
      case 'completed':
        return Colors.green;
      case 'pending':
        return Colors.orange; // Matches standard pending UI
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
