import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/controllers/home_controller.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_network_image.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_images.dart';
import '../BottomNavBar/driver_bottom_menu..dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  final HomeController _homeController = Get.put(HomeController());

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
                  return Center(
                    child: CircularProgressIndicator(),
                  );
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
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          //========================> Top Container <=================
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CustomNetworkImage(
                                      imageUrl:
                                          'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                                      height: 38.h,
                                      width: 38.w,
                                      boxShape: BoxShape.circle,
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Mr. Imran',
                                          bottom: 4.h,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Row(
                                          children: [
                                            CustomText(text: '4.9', right: 4.w),
                                            SvgPicture.asset(AppIcons.star),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //========================> Status Container <=================
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.h,
                                      vertical: 4.h,
                                    ),
                                    child: CustomText(
                                      text: AppStrings.ongoing.tr,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(thickness: 1.5, color: AppColors.borderColor),
                          //========================> Details Container <=================
                          Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: '\$15.99',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 22.sp,
                                  bottom: 8.h,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: CustomText(
                                        text: 'Booking Time :'.tr,
                                        fontWeight: FontWeight.w500,
                                        maxLine: 2,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomText(
                                        text: 'Sat 12 April 2025  8.30 PM',
                                        fontWeight: FontWeight.w500,
                                        maxLine: 2,
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 8.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: AppStrings.pICKUP.tr,
                                            right: 4.w,
                                            bottom: 12.h,
                                          ),
                                          CustomText(text: 'Dhaka', right: 4.w),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 102.w,
                                      child: Divider(
                                        thickness: 1.5,
                                        color: AppColors.borderColor,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          CustomText(
                                            text: AppStrings.dROPOFF.tr,
                                            left: 4.w,
                                            bottom: 12.h,
                                          ),
                                          CustomText(
                                            text: 'Rangpur',
                                            left: 4.w,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}