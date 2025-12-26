import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/controllers/home_controller.dart';
import 'package:ride_sharing/service/api_constants.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_network_image.dart';
import 'package:ride_sharing/views/base/custom_page_loading.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../../../../controllers/recent_order_controller.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../../../../base/custom_button.dart';
import '../BottomNavBar/driver_bottom_menu..dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());
  final RecentOrderController controller = Get.put(RecentOrderController());

  List<Map<String, String>> orderData = [
    {'title': 'Recent Orders'.tr},
    {'title': 'Active Orders'.tr},
    {'title': 'Completed Orders'.tr},
  ];

  @override
  Widget build(BuildContext context) {
    _homeController.fetchStatistics();
    return Scaffold(
      bottomNavigationBar: DriverBottomMenu(0),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AppImages.appLogo, width: 62.w, height: 52.h),
            Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationsScreen);
              },
              child: SvgPicture.asset(AppIcons.notification),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //================================> Top Order <=======================
            /* SizedBox(
              height: 191.h,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: orderData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8.w),
                    child: GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Get.toNamed(AppRoutes.recentOrderScreen);
                        } else if (index == 1) {
                          Get.toNamed(AppRoutes.activeOrderScreen);
                        } else {
                          Get.toNamed(AppRoutes.completedOrderScreen);
                        }},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.borderColor,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.h,
                                vertical: 16.h,
                              ),
                              child: SvgPicture.asset(AppIcons.orderTR),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.h),
                              child: CustomText(
                                 text: statsData[index]['title'] ?? '',
                                fontWeight: FontWeight.w500,
                                fontSize: 18.sp,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Divider(
                              thickness: 1.5,
                              color: AppColors.borderColor,
                            ),
                            SizedBox(height: 6.h),
                            Row(
                              children: [
                                CustomText(
                                  text: 'Total'.tr,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                                CustomText(
                                  left: 4.w,
                                  text: ': ${statsData[index]['count']}',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.sp,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),*/
            SizedBox(
              height: 191.h,
              child: Obx(() {
                if (_homeController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                final stats = _homeController.statisticsData.value;
                final attributes = stats['data']?['attributes'] ?? {};

                final statsData = [
                  {
                    'title': 'Recent Orders'.tr,
                    'count': attributes['recentOrders'] ?? 0,
                    'route': AppRoutes.recentOrderScreen,
                  },
                  {
                    'title': 'Active Orders'.tr,
                    'count': attributes['activeOrders'] ?? 0,
                    'route': AppRoutes.activeOrderScreen,
                  },
                  {
                    'title': 'Completed Orders'.tr,
                    'count': attributes['completeOrders'] ?? 0,
                    'route': AppRoutes.completedOrderScreen,
                  },
                ];

                return ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: statsData.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: GestureDetector(
                        onTap: () {
                          // Get.toNamed(statsData[index]['route']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.borderColor,
                            ),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            //mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.h,
                                  vertical: 16.h,
                                ),
                                child: SvgPicture.asset(AppIcons.orderTR),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.h),
                                child: CustomText(
                                  text: statsData[index]['title'] ?? '',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Divider(
                                thickness: 1.5,
                                color: AppColors.borderColor,
                              ),
                              SizedBox(height: 6.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Total'.tr,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp,
                                    ),
                                    CustomText(
                                      left: 4.w,
                                      text: ': ${statsData[index]['count']}',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14.sp,
                                      color: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 6.h),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 24.h),
            //================================> Recently accepted order <=======================
            CustomText(
              text: AppStrings.recentlyAcceptedOrder.tr,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              bottom: 16.h,
            ),
        Obx(() {
          if (controller.isLoading.value) {
            return const CustomPageLoading();
          }

          return Expanded(
            child: ListView.builder(
              itemCount: controller.recentOrders.length,
              itemBuilder: (context, index) {
                final order = controller.recentOrders[index];

                final rawStatus = order.status ?? '';
                final status = rawStatus.trim(); // use this for UI
                final statusColor = getStatusColor(rawStatus, context); // pass raw to normalize inside function

                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(width: 1.w, color: AppColors.borderColor),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8.r,
                          offset: Offset(0, 2.h),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // ================= PROFILE + STATUS =================
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  CustomNetworkImage(
                                    imageUrl:
                                    "${ApiConstants.imageBaseUrl}${order.user.image}",
                                    height: 42.h,
                                    width: 42.w,
                                    boxShape: BoxShape.circle,
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: order.user.userName,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      SizedBox(height: 4.h),
                                      Row(
                                        children: [
                                          CustomText(
                                            text: order.user.averageRating.toString(),
                                            fontSize: 12.sp,
                                            right: 4.w,
                                          ),
                                          SvgPicture.asset(
                                            AppIcons.star,
                                            height: 12.h,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: statusColor),
                                ),
                                child: CustomText(
                                  text: status.isNotEmpty ? status : 'N/A',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: statusColor,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Divider(color: AppColors.borderColor, height: 1),

                        // ================= PRICE =================
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Total Fare',
                                    fontSize: 12.sp,
                                    color: Colors.grey.shade600,
                                  ),
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    text: '\$${order.price}',
                                    fontSize: 24.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // ================= ROUTE =================
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  _locationDot(Colors.green),
                                  _verticalLine(),
                                  _locationDot(Colors.red, icon: Icons.location_on),
                                ],
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _addressBlock('Pickup', order.pickUp.address),
                                    SizedBox(height: 24.h),
                                    _addressBlock('Dropoff', order.dropOff.address),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================= BOOKING TIME =================
                        Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.calendar_today,
                                        size: 16.w, color: Colors.grey),
                                    SizedBox(width: 8.w),
                                    CustomText(
                                      text: 'Booking Time',
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600,
                                    ),
                                  ],
                                ),
                                CustomText(
                                  text: order.rideDate.isNotEmpty
                                      ? formatRideDate(order.rideDate)
                                      : '',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }),


        ],
        ),
      ),
    );
  }


  Widget _locationDot(Color color, {IconData icon = Icons.circle}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color, width: 2),
      ),
      child: Icon(icon, size: 10, color: color),
    );
  }

  Widget _verticalLine() {
    return Container(
      width: 2,
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 4),
      color: Colors.grey.shade300,
    );
  }

  Widget _addressBlock(String title, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 12,
          color: Colors.grey,
        ),
        const SizedBox(height: 4),
        CustomText(
          text: address,
          fontWeight: FontWeight.w500,
          maxLine: 2,
        ),
      ],
    );
  }


  Color getStatusColor(String? status, BuildContext context) {
    final normalized = (status ?? '').trim().toLowerCase();

    switch (normalized) {
      case 'ongoing':
        return AppColors.primaryColor; // your app primary color
      case 'completed':
        return Colors.green;
      case 'cancel':
      case 'cancelled':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }



  String formatRideDate(String date) {
    if (date.isEmpty) return '';

    final DateTime parsedDate = DateTime.parse(date).toLocal();

    /// Sat 12 April 2025  8.30 PM
    return DateFormat('EEE dd MMMM yyyy  h.mm a').format(parsedDate);
  }
}
