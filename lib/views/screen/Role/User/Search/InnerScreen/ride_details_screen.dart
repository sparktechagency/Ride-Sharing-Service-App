import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../models/booking_user_details_model.dart';
import '../../../../../../models/booking_with_status_model.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';


class RideDetailsScreen extends StatefulWidget {
  const RideDetailsScreen({super.key});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  String? selectedPayment;
  final BookingController bookingController = Get.isRegistered<BookingController>()
      ? Get.find<BookingController>()
      : Get.put(BookingController(), permanent: true);

  // Variables to hold the data received via Get.arguments
  // Note: These are defined late and initialized in the build method.
  late BookingAttribute? statusBooking;
  late BookingUserAttributes? userDetails;
  late String formattedDate;

  void _onSubmit() {
    if (selectedPayment != null) {
      debugPrint('Payment method selected: $selectedPayment');
      Navigator.of(context).pop(selectedPayment);
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- 1. RECEIVE AND EXTRACT ARGUMENTS ---
    final arguments = Get.arguments as Map<String, dynamic>?;
    final String fromScreen = arguments?['from'] ?? '';

    // Safely extract the passed data
    statusBooking = arguments?['booking'] as BookingAttribute?;
    userDetails = arguments?['user'] as BookingUserAttributes?;

    // Handle null case (should not happen if navigation from PendingTab is correct)
    if (statusBooking == null || userDetails == null) {
      return Scaffold(
        appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
        body: const Center(child: Text('Error: Ride or User details missing.')),
      );
    }

    // Format the date using the retrieved booking data
    formattedDate = DateFormat('EEE dd MMMM yyyy h.mm a')
        .format(DateTime.parse(statusBooking!.rideDate))
        .toLowerCase();
    // -----------------------------------------

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              //==================================> Ride Details <===================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    //========================> Top Container (Date) <=================
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.bgCalander),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: CustomText(
                              // Use the formatted date from the booking
                              text: formattedDate,
                              maxLine: 3,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    //========================> Details Container (Locations) <=================
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text: AppStrings.pICKUP.tr,
                                      bottom: 12.h,
                                    ),
                                    CustomText(
                                      // Use pickup address
                                        text: statusBooking?.pickUp.address ?? 'N/A',
                                        bottom: 12.h),
                                    CustomText(
                                      text: AppStrings.passenger.tr,
                                      bottom: 12.h,
                                    ),
                                    CustomText(
                                      text: AppStrings.vehiclesType.tr,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 106.w,
                                child: Divider(
                                  thickness: 1.5,
                                  color: AppColors.borderColor,
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomText(
                                      text: AppStrings.dROPOFF.tr,
                                      bottom: 12.h,
                                    ),
                                    CustomText(
                                      // Use dropoff address
                                        text: statusBooking?.dropOff.address ?? 'N/A',
                                        bottom: 12.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Use passenger count from booking
                                        CustomText(text: '${statusBooking?.numberOfPeople ?? 0}  '),

                                      ],
                                    ),
                                    SizedBox(height: 12.h),
                                    // Use vehicle type from booking
                                    CustomText(text: statusBooking?.vehicleType ?? ''),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: AppStrings.passenger.tr,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                // Use passenger count
                                text: '${statusBooking?.numberOfPeople ?? 0}',
                                fontWeight: FontWeight.w500,
                                fontSize: 20.sp,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(
                                text: AppStrings.ridePrice.tr,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                // Use ride price
                                text: '\$ ${statusBooking!.price.toStringAsFixed(2)}',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: AppColors.primaryColor,
                                right: 24.w,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    //==================================> Action Buttons <===================
                    Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 10.h),
                      child: Builder(
                        builder: (context) {
                          final BookingController bookingController = Get.find<BookingController>();

                          if (fromScreen == 'ongoing') {
                            return Obx(() => CustomButton(
                              onTap: () async {
                                bool success = await bookingController.updateBookingStatus(
                                  statusBooking!.id,
                                  "Completed",
                                );
                                if (success) {
                                  // Just go back and pass 'true' as the result
                                  Navigator.pop(context, true);
                                } else {
                                  // For errors, you can show them here since you aren't popping the screen
                                  Get.snackbar("Error", bookingController.errorMessage.value,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white);
                                }
                              },
                              loading: bookingController.isUpdatingStatus.value,
                              text: "Start Trip".tr, // Note: If the status is becoming 'Completed', usually the button says 'End Trip'
                              width: double.infinity,
                              height: 45.h,
                            ));
                          }else if (fromScreen == 'completed') {
                            // 2. Completed: Static Button
                            return CustomButton(
                              onTap: () {},
                              text: "Completed Trip".tr,
                              width: double.infinity,
                              height: 45.h,
                              color: Colors.grey,
                              broderColor: Colors.grey,
                            );
                          } else {
                            // 3. Pending: Cancel (Outlined) and Chat Now (CustomButton)
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // -------- Cancel Button --------
                                OutlinedButton(
                                  onPressed: () => _showCancelBottomSheet(context),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(color: AppColors.primaryColor),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                    minimumSize: Size(90.w, 34.h),
                                  ),
                                  child: Text(
                                    AppStrings.cancel.tr,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                // -------- Chat Now Button --------
                                CustomButton(
                                  onTap: () {
                                    // Logic to go to Chat
                                  },
                                  text: "Chat Now".tr,
                                  width: 100.w,
                                  height: 34.h,
                                  fontSize: 12.sp,
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),

                  ],
                ),
              ),
              SizedBox(height: 24.h),
              //==================================> Driver Details <===================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Column(
                  children: [
                    //========================> Top Container <=================
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Flexible(
                                  child: CustomText(
                                    text: AppStrings.details.tr,
                                    maxLine: 3,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
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
                          //=====================> Name & Image Row <=================
                          Row(
                            children: [
                              // CustomNetworkImage(
                              //   // Use user image
                              //   imageUrl: userDetails!.profilePic ??
                              //       'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                              //   height: 38.h,
                              //   width: 38.w,
                              //   boxShape: BoxShape.circle,
                              // ),
                              SizedBox(width: 8.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    // Use user name
                                    text: userDetails!.userName ?? '',
                                    bottom: 4.h,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  Row(
                                    children: [
                                      CustomText(
                                        // Use rating
                                          text: userDetails!.averageRating
                                              .toString() ??
                                              '0',
                                          right: 4.w),
                                      SvgPicture.asset(AppIcons.star),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Date of Birth Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.calender),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.dateOfBirth.tr,
                                        ),
                                        CustomText(
                                          // Use date of birth
                                          text: userDetails!.dateOfBirth ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Location and Distance Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.location),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.location.tr,
                                        ),
                                        CustomText(
                                          // Use address
                                          text: userDetails!.address ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Vehicles Type Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.type),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.vehiclesType.tr,
                                        ),
                                        CustomText(
                                          // Use vehicle type
                                          text: userDetails!.vehicleType ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Reviews Section <=================
                          (userDetails!.reviews.isNotEmpty)
                              ? CustomText(
                            text: AppStrings.reviews.tr,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            bottom: 16.h,
                          )
                              : const SizedBox(),

                          (userDetails!.reviews.isNotEmpty)
                              ? Column(
                            children: userDetails!.reviews.map((review) {
                              final reviewFormattedDate = review['date'] == null
                                  ? ''
                                  : DateFormat('EEE dd MMMM yyyy h.mm a')
                                  .format(DateTime.parse(review['date']))
                                  .toLowerCase();

                              return Padding(
                                padding: EdgeInsets.only(bottom: 8.h),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(width: 1.w, color: AppColors.borderColor),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(12.w),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomNetworkImage(
                                          imageUrl: review['userImage'] ??
                                              "${ApiConstants.imageBaseUrl}${userDetails?.profileImage}",
                                          height: 38.h,
                                          width: 38.w,
                                          boxShape: BoxShape.circle,
                                        ),
                                        SizedBox(width: 8.w),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: review['userName'] ?? '',
                                                bottom: 4.h,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              CustomText(
                                                text: reviewFormattedDate,
                                                fontSize: 9.sp,
                                              ),
                                              Row(
                                                children: List.generate(
                                                  review['rating'] ?? 0,
                                                      (index) => const Icon(
                                                    Icons.star,
                                                    color: Colors.orange,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              CustomText(
                                                text: review['comment'] ?? '',
                                                maxLine: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                              : const SizedBox.shrink(),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  //===============================> Payment Bottom Sheet <===============================
  _showPaymentBottomSheet(BuildContext context) {
    String? selectedPaymentOption;

    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 330.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.h),
                      width: 40.w,
                      height: 5.h,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  Center(
                    child: CustomText(
                      text: AppStrings.paymentSystem.tr,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  _paymentOption(
                    AppStrings.cashPayment.tr,
                    statusBooking!.price.toDouble() , // Use actual price
                    'cash',
                    selectedPaymentOption,
                        (val) => setState(() => selectedPaymentOption = val),
                  ),
                  _paymentOption(
                    AppStrings.onlinePayment.tr,
                    statusBooking!.price.toDouble(), // Use actual price
                    'online',
                    selectedPaymentOption,
                        (val) => setState(() => selectedPaymentOption = val),
                  ),
                  SizedBox(height: 16.h),
                  CustomButton(
                    width: 288.w,
                    onTap: () {
                      if (selectedPaymentOption != null) {
                        // Update the screen's state and close bottom sheet
                        setState(() {
                          selectedPayment = selectedPaymentOption;
                        });
                        Navigator.of(context).pop();
                        _onSubmit();
                      }
                    },
                    text: AppStrings.submit.tr,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showCancelBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 16.h),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),

              CustomText(
                text: AppStrings.cancelRide.tr,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                bottom: 8.h,
              ),

              CustomText(
                text: AppStrings.confirmRideCancelConfirmation.tr,
                fontSize: 14.sp,
                bottom: 12.h,
              ),

              CustomText(
                text:
                 AppStrings.confirmRideCancelAlert.tr,
                fontSize: 12.sp,
                color: Colors.red,
                textAlign: TextAlign.center,
                bottom: 20.h,
                maxLine: 5,
              ),

              Row(
                children: [
                  // -------- Cancel Button --------
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          AppStrings.cancel.tr,
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // -------- Yes Button --------
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          // 🔥 Call cancel API here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          AppStrings.yes.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),


              SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
            ],
          ),
        );
      },
    );
  }


  //===========================================> Payment Option <==================================
  _paymentOption(
      String label,
      double price,
      String value,
      String? groupValue,
      ValueChanged<String?> onChanged,
      ) {
    final isSelected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(10.h),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Container(
          width: 288.w,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.white,
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey.shade300,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.15),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Radio<String>(
                value: value,
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: Colors.blue,
                fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.selected)) {
                    return AppColors.primaryColor;
                  }
                  return Colors.grey;
                }),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '\$${price.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}