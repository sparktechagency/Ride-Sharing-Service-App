import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/screen/Role/User/Search/InnerScreen/search_ride_detail_screen.dart';
import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../controllers/search_ride_controller.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class SeeAllScreen extends StatelessWidget {
  const SeeAllScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Access the existing controller instance
    final SearchRideController controller = Get.find<SearchRideController>();
    final BookingController bookingController = Get.put(BookingController());

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.planYourRide.tr),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                // 2. Show loader while the API call is in progress
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                // 3. Use the 'rides' list from your controller
                if (controller.rides.isEmpty) {
                  return Center(
                    child: CustomText(text: "No Rides Found".tr),
                  );
                }

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: controller.rides.length,
                  itemBuilder: (context, index) {
                    final ride = controller.rides[index];

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
                            //========================> Details Container <=================
                            Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: 'Booking Time :'.tr,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(width: 8.w), // space between label and value
                                      Expanded(
                                        child: CustomText(
                                          text: ride.goingDate != null
                                              ? DateFormat('EEE d MMM yyyy hh:mm a').format(ride.goingDate!)
                                              : 'TBA',
                                          fontWeight: FontWeight.w500,
                                          maxLine: 2,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 8.h),
                                  CustomText(
                                    text: '\$${ride.pricePerSeat}',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22.sp,
                                    bottom: 8.h,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(text: AppStrings.pICKUP.tr, bottom: 12.h),
                                            // 5. Dynamic Pickup Address
                                            CustomText(text: ride.pickUp.address, bottom: 8.w, maxLine: 2),
                                            CustomText(text: 'Passenger'.tr,bottom: 8.w, maxLine: 2),
                                            CustomText(text: 'Seat Booked'.tr),
                                          ],
                                        ),
                                      ),
                                      // Visual separator (Distance indicator)
                                      Padding(
                                        padding: EdgeInsets.only(top: 20.h),
                                        child: SizedBox(
                                          width: 60.w,
                                          child: Divider(thickness: 1.5, color: AppColors.borderColor),
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            CustomText(text: AppStrings.dROPOFF.tr, bottom: 12.h),
                                            // 6. Dynamic Dropoff Address
                                            CustomText(text: ride.dropOff.address, bottom: 8.w, textAlign: TextAlign.end, maxLine: 2),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                // 7. Dynamic Passenger Count
                                                CustomText(text: '${ride.totalPassenger} ',bottom: 8.w),
                                                // CustomText(text: 'Person'.tr),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                // 7. Dynamic Passenger Count
                                                CustomText(text: '${ride.seatsBooked} '),
                                                // CustomText(text: 'Person'.tr),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Divider(thickness: 1.5, color: AppColors.borderColor),
                            //========================> Driver Info Container <=================
                            Padding(
                              padding: EdgeInsets.all(10.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Row(
                                    children: [
                                      // Placeholder image - your model doesn't have a driver image URL yet
                                      CustomNetworkImage(

                                        imageUrl:
                                        "${ApiConstants.imageBaseUrl}${ride.driverId.image}",
                                        height: 38.h,
                                        width: 38.w,
                                        boxShape: BoxShape.circle,
                                      ),
                                      // const CircleAvatar(
                                      //   radius: 19,
                                      //   backgroundImage: NetworkImage('https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg'),
                                      // ),
                                      SizedBox(width: 8.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // 8. Driver Name (Derived from email in your model)
                                          CustomText(
                                            text: ride.driverId.userName.capitalize ?? '',
                                            fontWeight: FontWeight.w500,

                                          ),
                                          CustomText(
                                            text: ride.driverId.email,
                                            fontWeight: FontWeight.w500,
                                            maxLine: 5,
                                          ),

                                        ],
                                      ),
                                    ],
                                  ),

                                  CustomButton(
                                    onTap: () {
                                      Get.to(() => const SearchRideDetailsScreen(), // Navigate to the NEW screen
                                        arguments: {
                                          'booking': ride,
                                          'user': ride.driverId,
                                          "id" : ride.id,
                                        },
                                      );
                                    },
                                    width: 100.w,
                                    height: 37.h,
                                    text: AppStrings.view.tr,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
            SizedBox(height: 24.h)
          ],
        ),
      ),
    );
  }
}