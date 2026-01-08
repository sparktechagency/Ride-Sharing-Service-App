import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../models/create_booking_response_model.dart';
import '../../../../../../models/search_ride_model.dart' hide GeoLocation;
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class SearchRideDetailsScreen extends StatefulWidget {
  const SearchRideDetailsScreen({super.key});

  @override
  State<SearchRideDetailsScreen> createState() => _SearchRideDetailsScreenState();
}

class _SearchRideDetailsScreenState extends State<SearchRideDetailsScreen> {
  final BookingController bookingController = Get.isRegistered<BookingController>()
      ? Get.find<BookingController>()
      : Get.put(BookingController(), permanent: true);

  @override
  void initState() {
    super.initState();

    // Clear old data so we don't see the previous driver's info
    bookingController.userDetails.value = null;

    final dynamic driver = Get.arguments?['user'];
    if (driver != null) {
      bookingController.getBookingUserDetails(driver.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;

    final dynamic ride = arguments?['booking'];
    final dynamic driverArg = arguments?['user'];

    if (ride == null || driverArg == null) {
      return Scaffold(
        appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
        body: const Center(child: Text('Error: Ride or Driver details missing.')),
      );
    }

    // Ride Data Prep
    String formattedDate = 'N/A';
    try {
      if (ride.goingDate != null) {
        formattedDate = DateFormat('EEE dd MMMM yyyy h.mm a')
            .format(ride.goingDate!)
            .toLowerCase();
      }
    } catch (e) {
      debugPrint("Date error: $e");
    }

    final String pickupAddr = ride.pickUp?.address ?? 'N/A';
    final String dropoffAddr = ride.dropOff?.address ?? 'N/A';
    final String ridePrice = (ride.pricePerSeat ?? 0).toStringAsFixed(2);
    final String passengerCount = (ride.totalPassenger ?? 0).toString();
    final String vehicleType = driverArg.vehicleType ?? 'N/A';

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              //==================================> Ride Details (STAYS SAME) <===================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppIcons.bgCalander),
                          SizedBox(width: 8.w),
                          Flexible(
                            child: CustomText(
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText(
                        text: '\$${ride.pricePerSeat}',
                        fontWeight: FontWeight.w600,
                        fontSize: 22.sp,

                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: AppStrings.pICKUP.tr, bottom: 12.h),

                                CustomText(text: getFirstAddress(ride), bottom: 12.h),
                                CustomText(text: AppStrings.passenger.tr, bottom: 12.h),
                                CustomText(text: AppStrings.vehiclesType.tr),
                              ],
                            ),
                          ),
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
                                CustomText(text: getLastAddress(ride), bottom: 12.h, textAlign: TextAlign.end),
                                CustomText(text: passengerCount, bottom: 12.h),
                                CustomText(text: vehicleType),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(text: AppStrings.passenger.tr, fontWeight: FontWeight.w500),
                              CustomText(text: passengerCount, fontWeight: FontWeight.w500, fontSize: 20.sp),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomText(text: AppStrings.ridePrice.tr, fontWeight: FontWeight.w500),
                              CustomText(
                                text: '\$ $ridePrice',
                                fontWeight: FontWeight.w600,
                                fontSize: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 10.h),
                      child: CustomButton(
                        onTap: () {
                          _showBookingConfirmation(context, ride, driverArg);
                        },
                        text: "Book Now".tr,
                        width: double.infinity,
                        height: 45.h,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              //==================================> Driver Details (UPDATED PART) <===================
              Obx(() {
                if (bookingController.isLoadingUser.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final user = bookingController.userDetails.value;

                if (user == null) {
                  return const SizedBox.shrink();
                }

                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(width: 1.w, color: AppColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Row(
                          children: [
                            CustomText(text: AppStrings.details.tr, fontWeight: FontWeight.w600),
                          ],
                        ),
                      ),
                      Divider(thickness: 1.5, color: AppColors.borderColor),
                      Padding(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Driver Header
                            Row(
                              children: [
                                CustomNetworkImage(
                                  imageUrl: "${ApiConstants.imageBaseUrl}${user.profileImage}",
                                  height: 38.h,
                                  width: 38.w,
                                  boxShape: BoxShape.circle,
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: user.userName, fontWeight: FontWeight.w500),
                                    Row(
                                      children: [
                                        CustomText(text: '${user.averageRating}', right: 4.w),
                                        SvgPicture.asset(AppIcons.star),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),

                            // Info Rows from API
                            _buildDriverInfoRow(
                                AppIcons.calender,
                                AppStrings.dateOfBirth.tr,
                                user.dateOfBirth != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(user.dateOfBirth!)) : 'N/A'
                            ),
                            SizedBox(height: 24.h),
                            _buildDriverInfoRow(AppIcons.location, AppStrings.location.tr, user.address),
                            SizedBox(height: 24.h),
                            _buildDriverInfoRow(AppIcons.type, AppStrings.vehiclesType.tr, "${user.vehicleType} - ${user.vehicleModel}"),

                            // Reviews
                            if (user.reviews.isNotEmpty) ...[
                              SizedBox(height: 24.h),
                              CustomText(text: AppStrings.reviews.tr, fontSize: 16.sp, fontWeight: FontWeight.w600, bottom: 16.h),
                              ...user.reviews.map<Widget>((review) => _buildReviewCard(review, user)),
                            ]
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI HELPERS ---


  String getFirstAddress(RideAttribute ride) {
    return ride.pickUp.address;
  }


  String getLastAddress(RideAttribute ride) {
    if (ride.stopOver.isNotEmpty) {
      return ride.stopOver.last.address;
    }
    return ride.dropOff.address;
  }

  Widget _buildDriverInfoRow(String icon, String label, String value) {
    return Row(
      children: [
        SvgPicture.asset(icon, color: AppColors.primaryColor, width: 20.w),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: label, fontSize: 12.sp, color: Colors.grey),
            CustomText(text: value, fontSize: 16.sp, fontWeight: FontWeight.w500),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewCard(dynamic review, dynamic user) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomNetworkImage(
            imageUrl: "${ApiConstants.imageBaseUrl}${review.reviewer?.image ?? ''}",
            height: 38.h, width: 38.w, boxShape: BoxShape.circle,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: review.reviewer?.userNameSelf ?? 'User', fontWeight: FontWeight.w500),
                Row(
                  children: List.generate(5, (index) => Icon(
                      Icons.star,
                      size: 14,
                      color: index < (review.rating ?? 0) ? Colors.orange : Colors.grey[300]
                  )),
                ),
                CustomText(text: review.review ?? '', maxLine: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }



  void _showBookingConfirmation(BuildContext context, dynamic ride, dynamic driverArg) {
    RxInt count = 1.obs;

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white, // Prevents tint color in newer Flutter versions
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(text: "Confirm Booking", fontWeight: FontWeight.w600, fontSize: 18.sp),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: "How many seats do you want to book?".tr),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => count.value > 1 ? count.value-- : null,
                  icon: Icon(Icons.remove_circle_outline, color: AppColors.primaryColor),
                ),
                Obx(() => CustomText(
                  text: count.value.toString(),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  left: 10.w,
                  right: 10.w,
                )),
                IconButton(
                  onPressed: () {
                    if (count.value < (ride.totalPassenger ?? 1)) {
                      count.value++;
                    }
                  },
                  icon: Icon(Icons.add_circle_outline, color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
        actionsPadding: EdgeInsets.only(right: 16.w, bottom: 16.h, left: 16.w), // Better spacing
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Cancel Button
              TextButton(
                onPressed: () => Get.back(),
                child: CustomText(text: "Cancel".tr, color: Colors.red, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 8.w),
              // Confirm Button
              Obx(() => CustomButton(
                width: 120.w,  // Give it a fixed width
                height: 40.h,  // Give it a smaller height for the dialog
                fontSize: 14.sp,
                loading: bookingController.isLoadingBooking.value, // Use the built-in loading property
                onTap: () async {
                  final createBookingPickUp = CreateBookingLocationInfo(
                    address: ride.pickUp.address,
                    location: GeoLocation(
                      type: ride.pickUp.location.type,
                      coordinates: ride.pickUp.location.coordinates,
                    ),
                  );

                  final createBookingDropOff = CreateBookingLocationInfo(
                    address: ride.dropOff.address,
                    location: GeoLocation(
                      type: ride.dropOff.location.type,
                      coordinates: ride.dropOff.location.coordinates,
                    ),
                  );

                  final result = await bookingController.createBooking(
                    driverId: driverArg.id,
                    price: (ride.pricePerSeat ?? 0).toInt(),
                    numberOfPeople: count.value,
                    vehicleType: driverArg.vehicleType ?? 'bike',
                    pickUp: createBookingPickUp,
                    dropOff: createBookingDropOff,
                    rideDate: ride.goingDate?.toIso8601String() ?? '',
                    rideId: ride.id,
                  );

                  if (result != null) {
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomText(text: "Booking created successfully!".tr, color: Colors.white),
                        backgroundColor: AppColors.primaryColor,
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: CustomText(text: bookingController.errorMessage.value, color: Colors.white),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                text: 'Confirm',
              )),
            ],
          ),
        ],
      ),
    );
  }}