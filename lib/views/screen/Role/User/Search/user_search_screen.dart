import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import 'package:ride_sharing/views/base/custom_text_field.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_images.dart';
import '../../../../../controllers/booking_controller.dart';
import '../../../../../controllers/search_ride_controller.dart';
import '../BottomNavBar/user_bottom_menu..dart';
import 'InnerScreen/map_pick_screen.dart';

class UserSearchScreen extends StatelessWidget {
  UserSearchScreen({super.key});

  final TextEditingController pickUpCTRL = TextEditingController();
  final TextEditingController dropOffCTRL = TextEditingController();
  final TextEditingController dateCTRL = TextEditingController();
  final TextEditingController passengerCTRL = TextEditingController();

  final SearchRideController controller =
  Get.put(SearchRideController());
  final BookingController bookingController = Get.put(BookingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UserBottomMenu(0),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AppImages.appLogo, width: 62.w, height: 52.h),
            const Spacer(),
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================================> Search Container <=======================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    children: [
                      //================================> Pick Up <=======================
                      CustomTextField(
                        readOnly: true,
                        controller: pickUpCTRL,
                        hintText: AppStrings.pICKUP.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.location,
                          color: AppColors.primaryColor,
                        ),
                        onTab: () async {
                          controller.currentSearchType.value = 'pickup';
                          final result = await Get.to(() => const MapPickerScreen());

                          if (result is SelectionResult) {
                            controller.pickupLatLng.value = result.latLng;
                            pickUpCTRL.text = result.address;
                            controller.calculateDistance();
                          }
                        },

                      ),

                      SizedBox(height: 8.h),

                      //================================> Drop Off <=======================
                      CustomTextField(
                        readOnly: true,
                        controller: dropOffCTRL,
                        hintText: AppStrings.dROPOFF.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.location,
                          color: AppColors.primaryColor,
                        ),
                        onTab: () async {
                          controller.currentSearchType.value = 'dropoff';
                          final result = await Get.to(() => const MapPickerScreen());

                          if (result is SelectionResult) {
                            controller.dropoffLatLng.value = result.latLng;
                            dropOffCTRL.text = result.address;
                            controller.calculateDistance();
                          }
                        },
                      ),

                      SizedBox(height: 8.h),

                      //================================> Date <=======================
                      CustomTextField(
                        onTab: () => pickDate(context),
                        readOnly: true,
                        controller: dateCTRL,
                        hintText: 'Select Date'.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.calender,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      //=============================> Vehicle Type Dropdown <=========================
                      Obx(
                            () => DropdownButtonFormField<String>(
                          // 1. Set the background color of the popup menu to white
                          dropdownColor: Colors.white,

                          // 2. Set the text style for the selected value and items
                          style: TextStyle(
                            color: Colors.black, // Makes the value text black
                            fontSize: 16.sp,
                          ),

                          value: controller.selectedVehicle.value.isEmpty
                              ? null
                              : controller.selectedVehicle.value,
                          decoration: InputDecoration(
                            hintText: 'Select Vehicles Type'.tr,
                            hintStyle: TextStyle(color: Colors.grey), // Ensure hint isn't pure black
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: SvgPicture.asset(
                                AppIcons.car,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: AppColors.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.r),
                              borderSide: BorderSide(color: AppColors.borderColor),
                            ),
                          ),
                          items: controller.vehicleTypes
                              .map(
                                (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(color: Colors.black), // Ensures items are black
                              ),
                            ),
                          )
                              .toList(),
                          onChanged: (value) {
                            controller.selectedVehicle.value = value ?? '';
                          },
                        ),
                      ),
                      SizedBox(height: 8.h),

                      //================================> Passenger <=======================
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: passengerCTRL,
                        hintText: 'Passenger'.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.profileOutline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      Obx(() => CustomButton(
                        onTap: () {
                          final messenger = ScaffoldMessenger.of(Get.context!);

                          // --- VALIDATION ---
                          void showError(String message) {
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text(message, style: const TextStyle(color: Colors.white)),
                                backgroundColor: AppColors.errorColor,
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          }

                          if (pickUpCTRL.text.isEmpty) {
                            showError('Pickup location is required');
                            return;
                          }
                          if (dropOffCTRL.text.isEmpty) {
                            showError('Dropoff location is required');
                            return;
                          }
                          if (dateCTRL.text.isEmpty) {
                            showError('Date is required');
                            return;
                          }

                          final passengers = int.tryParse(passengerCTRL.text) ?? 0;
                          if (passengers <= 0) {
                            showError('Number of passengers must be greater than 0');
                            return;
                          }

                          if (controller.selectedVehicle.value.isEmpty) {
                            showError('Please select a vehicle');
                            return;
                          }

                          if (controller.pickupLatLng.value == null || controller.dropoffLatLng.value == null) {
                            showError('Pickup and Dropoff coordinates not set');
                            return;
                          }

                          // --- SAVE SEARCH LOCALLY ---
                          controller.saveSearchLocally(
                            pickup: pickUpCTRL.text,
                            dropoff: dropOffCTRL.text,
                            date: dateCTRL.text,
                            passengers: passengers,
                          );

                          // --- PERFORM API SEARCH ---
                          controller.searchRide(
                            date: dateCTRL.text,
                            passenger: passengers,
                          );

                          // --- NAVIGATE TO RESULTS ---
                          Get.toNamed(AppRoutes.seeAllScreen);
                        },
                        loading: controller.isDistanceLoading.value,
                        height: 45.h,
                        text: controller.isDistanceLoading.value
                            ? "Calculating..."
                            : AppStrings.search.tr,
                        color: controller.isDistanceLoading.value
                            ? Colors.grey
                            : AppColors.primaryColor,
                      ))



                    ],
                  ),
                ),
              ),

              SizedBox(height: 24.h),

              //================================> Recently Search <=======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppStrings.recentSearch.tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),

                ],
              ),

              SizedBox(height: 16.h),

              //================================> Dynamic Recent List <=======================
              Obx(() => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.recentSearches.length,
                itemBuilder: (context, index) {
                  final data = controller.recentSearches[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(width: 1.w, color: AppColors.borderColor),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(AppIcons.clock, color: AppColors.primaryColor),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Pickup → Arrow → Dropoff stacked properly
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          data.pickup,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                                        child: const Icon(Icons.arrow_forward_outlined, size: 16),
                                      ),
                                      Expanded(
                                        child: Text(
                                          data.dropoff,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16.sp,
                                          ),
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    '${data.date} • ${data.passengers} Passenger',
                                    style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8.w),
                            SvgPicture.asset(AppIcons.rightArrow),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),


            ],
          ),
        ),
      ),
    );
  }

  //==========================> Date Picker <=======================
  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), // Allow older dates
      lastDate: DateTime(3050),  // Keep max far in the future
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      // Use .padLeft(2, '0') to ensure 2025-10-24 format
      String year = pickedDate.year.toString();
      String month = pickedDate.month.toString().padLeft(2, '0');
      String day = pickedDate.day.toString().padLeft(2, '0');

      dateCTRL.text = "$year-$month-$day";
    }
  }

}
