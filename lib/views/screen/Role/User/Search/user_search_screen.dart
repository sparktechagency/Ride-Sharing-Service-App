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
                          value: controller.selectedVehicle.value.isEmpty
                              ? null
                              : controller.selectedVehicle.value,
                          decoration: InputDecoration(
                            hintText: 'Select Vehicles Type'.tr,
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
                              child: Text(e),
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

                      //================================> Search Button <=======================
                      Obx(() => CustomButton(
                        onTap: () {
                          controller.searchRide(
                            date: dateCTRL.text,
                            passenger: int.tryParse(passengerCTRL.text) ?? 1,
                          );
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
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.seeAllScreen);
                    },
                    child: CustomText(
                      text: AppStrings.seeAll.tr,
                      fontWeight: FontWeight.w500,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              //================================> Static Recent List <=======================
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  AppIcons.clock,
                                  color: AppColors.primaryColor,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomText(
                                          text: 'Dhaka',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                        SizedBox(width: 8.w),
                                        const Icon(Icons.arrow_forward_outlined),
                                        SizedBox(width: 8.w),
                                        CustomText(
                                          text: 'Sylhet',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp,
                                        ),
                                      ],
                                    ),
                                    const CustomText(
                                      text: 'Thu 10 Apr. 1 Passenger',
                                      color: Colors.grey,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SvgPicture.asset(AppIcons.rightArrow),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
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
      firstDate: DateTime.now(),
      lastDate: DateTime(3050),
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
      dateCTRL.text =
      "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
    }
  }
}
