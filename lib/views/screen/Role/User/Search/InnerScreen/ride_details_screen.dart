import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../controllers/booking_controller.dart';
import '../../../../../../controllers/create_message_room_controller.dart';
import '../../../../../../controllers/rating_controller.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../models/booking_user_details_model.dart';
import '../../../../../../models/booking_with_status_model.dart';
import '../../../../../../models/single_ride_details_model.dart';
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
  late String fromScreen;
  late String riderId;
  late String driverId;
  late BookingAttribute? statusBooking;
  late BookingUserAttributes? userDetails;

  void _onSubmit() {
    if (selectedPayment != null) {
      debugPrint('Payment method selected: $selectedPayment');
      Navigator.of(context).pop(selectedPayment);
    }
  }

  @override
  void initState() {
    super.initState();

    // Get arguments
    final arguments = Get.arguments as Map<String, dynamic>?;

    fromScreen = arguments?['from'] ?? '';
    driverId = arguments?['driverId'] ?? arguments?['booking']?['driverId'] ?? '';
    statusBooking = arguments?['booking'] as BookingAttribute?;
    userDetails = arguments?['user'] as BookingUserAttributes?;
    riderId = statusBooking?.id ?? arguments?['id'] ?? '';
    // Load user details for the driver if needed
    if (driverId.isNotEmpty) {
      bookingController.getBookingUserDetails(driverId);
    }
  }

  double calculateWithdrawAmount(int price, int passengers) {
    return (price * passengers) * 0.90;
  }

  @override
  Widget build(BuildContext context) {
    if (statusBooking == null || userDetails == null) {
      return Scaffold(
        appBar: CustomAppBar(title: AppStrings.completedOrdersDetails.tr),
        body: const Center(child: Text('Error: Ride or User details missing.')),
      );
    }

    final formattedDate = DateFormat('EEE dd MMMM yyyy h.mm a')
        .format(DateTime.parse(statusBooking!.rideDate))
        .toLowerCase();

    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.rideDetails.tr),
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
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                      child: Builder(
                        builder: (context) {
                          // 1. COMPLETED STATE
                          if (fromScreen == 'completed') {
                            return CustomButton(
                              onTap: () {},
                              text: "Completed Trip".tr,
                              width: double.infinity,
                              height: 48.h,
                              color: Colors.grey,
                              broderColor: Colors.grey,
                            );
                          }

                          // 2. CANCELLED STATE
                          else if (fromScreen == 'cancelled') {
                            return CustomButton(
                              onTap: () {},
                              text: "Cancelled".tr,
                              width: double.infinity,
                              height: 48.h,
                              color: Colors.red.shade300,
                              broderColor: Colors.red.shade300,
                            );
                          }

                          else if (fromScreen == 'ongoing') {
                            return Obx(() => CustomButton(
                              onTap: () async {
                                bool success = await bookingController.updateBookingStatus(statusBooking!.id, "completed");
                                if (success) Navigator.pop(context, true);
                              },
                              loading: bookingController.isUpdatingStatus.value,
                              text: "Complete Trip".tr,
                              height: 48.h,
                            ));
                          }

                          // 3. ACTIVE STATE (Pending or Ongoing)
                          else {
                            return Row(
                              children: [
                                // CANCEL BUTTON
                                Expanded(
                                  flex: 1,
                                  child: OutlinedButton(
                                    onPressed: () => _showCancelBottomSheet(context),
                                    style: OutlinedButton.styleFrom(
                                      side: BorderSide(color: Colors.red.shade400, width: 1.w),
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                                      minimumSize: Size(double.infinity, 48.h),
                                    ),
                                    child: Text(
                                      AppStrings.cancel.tr,
                                      style: TextStyle(
                                          color: Colors.red.shade400,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                // START / COMPLETE TRIP BUTTON
                                Expanded(
                                  flex: 2,
                                  child: Obx(() => CustomButton(
                                    onTap: () async {
                                      bool success = await bookingController.updateBookingStatus(statusBooking!.id, "ongoing");
                                      if (success) Navigator.pop(context, true);
                                    },
                                    loading: bookingController.isUpdatingStatus.value,
                                    text: "Start Trip".tr,
                                    height: 48.h,
                                  )),
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
                    Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: AppStrings.details.tr,
                            fontWeight: FontWeight.w600,
                          ),
                          //=====================> CHAT NOW BUTTON (Moved Here) <=================
                          GestureDetector(
                            onTap: () {
                              final userId = userDetails?.userId;

                              if (userId != null && userId.isNotEmpty) {
                                _showChatConfirmation(context, userId);
                              } else {
                                Get.snackbar("Notice", "Chat is currently unavailable for this user.");
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.chat_outlined, size: 16.sp, color: AppColors.primaryColor),
                                  SizedBox(width: 4.w),
                                  CustomText(
                                    text: "Chat".tr,
                                    fontSize: 12.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(thickness: 1.5, color: AppColors.borderColor),
                    Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name & Image Row
                          Row(
                            children: [
                              CustomNetworkImage(
                                imageUrl: "${ApiConstants.imageBaseUrl}${userDetails!.profileImage}",
                                height: 50.h,
                                width: 50.w,
                                boxShape: BoxShape.circle,
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: userDetails!.userName,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16.sp,
                                  ),
                                  if (userDetails?.averageRating != null && userDetails!.averageRating! > 0)
                                    Row(
                                      children: [
                                        CustomText(text: userDetails!.averageRating.toString(), right: 4.w),
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
                          //=====================> Users in Ride Section <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: "User Reviews".tr,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                bottom: 16.h,
                              ),
                              // Only show "Give Review" if the trip is completed
                              if (fromScreen == 'completed')
                                TextButton.icon(
                                  onPressed: () {

                                    final userId = userDetails?.userId;

                                    if (userId != null && userId.isNotEmpty) {
                                      _showReviewDialog(context, userId);
                                    } else {
                                      Get.snackbar("Notice", "Review is currently unavailable for this user.");
                                    }
                                  },
                                  icon: Icon(Icons.rate_review_outlined, size: 18.sp, color: AppColors.primaryColor),
                                  label: CustomText(
                                    text: "Give Review".tr,
                                    fontSize: 14.sp,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                            ],
                          ),

// Check if reviews list is empty
                          userDetails!.reviews.isEmpty
                              ? Center(child: CustomText(text: "No reviews yet".tr, top: 10.h, bottom: 10.h))
                              : ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: userDetails!.reviews.length,
                            separatorBuilder: (context, index) => SizedBox(height: 16.h),
                            itemBuilder: (context, index) {
                              final review = userDetails!.reviews[index];

                              // Formatting date (Assuming createDate is an ISO string)
                              String reviewDate = "";
                              try {
                                reviewDate = DateFormat('dd MMM, yyyy').format(DateTime.parse(review.createDate));
                              } catch (e) {
                                reviewDate = review.createDate;
                              }

                              return Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.05),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(color: AppColors.borderColor.withOpacity(0.5)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [

                                            CustomNetworkImage(
                                              imageUrl: "${ApiConstants.imageBaseUrl}${review.reviewer.image}",
                                              height: 38.h,
                                              width: 38.w,
                                              boxShape: BoxShape.circle,
                                            ),

                                            SizedBox(width: 10.w),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                CustomText(
                                                  text: review.reviewer.userNameSelf,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.sp,
                                                ),
                                                CustomText(
                                                  text: reviewDate,
                                                  fontSize: 12.sp,
                                                  color: Colors.grey,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        // Star Rating Row
                                        Row(
                                          children: List.generate(5, (starIndex) {
                                            return Icon(
                                              Icons.star,
                                              size: 16.sp,
                                              color: starIndex < review.rating
                                                  ? Colors.amber
                                                  : Colors.grey.shade300,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      text: review.review,
                                      fontSize: 13.sp,
                                      maxLine: 5,
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),


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

  void _showReviewDialog(BuildContext context, String user,) {
    final RatingController ratingController = Get.put(RatingController());
    final TextEditingController feedbackController = TextEditingController();
    RxInt selectedStars = 0.obs;

    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), shape: BoxShape.circle),
                child: Icon(Icons.check_circle, color: Colors.green, size: 40.w),
              ),
              SizedBox(height: 16.h),
              CustomText(text: "Give Person rating out of 5!".tr, fontSize: 18.sp, fontWeight: FontWeight.bold),
              SizedBox(height: 20.h),
              CustomText(text: userDetails?.userName ?? '', fontSize: 16.sp, fontWeight: FontWeight.w600),
              SizedBox(height: 16.h),
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => selectedStars.value = index + 1,
                    icon: Icon(index < selectedStars.value ? Icons.star : Icons.star_border, color: Colors.amber, size: 32.w),
                  );
                }),
              )),
              SizedBox(height: 16.h),
              Align(alignment: Alignment.centerLeft, child: CustomText(text: "Write your feedback".tr, fontSize: 14.sp)),
              SizedBox(height: 8.h),
              TextField(
                controller: feedbackController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Type here...".tr,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () => Navigator.pop(dialogContext),
                      text: "Cancel".tr,
                      color: AppColors.backgroundColor,
                      broderColor: Colors.grey.shade300,
                      textColor: Colors.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Obx(() => CustomButton(
                      loading: ratingController.isLoading.value,
                      onTap: () async {
                        if (selectedStars.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select stars")));
                          return;
                        }
                        final result = await ratingController.createRating(
                          context: context,
                          ride: riderId,
                          target_id: userDetails?.userId.toString() ?? '',
                          stars: selectedStars.value,
                          review: feedbackController.text,
                        );
                        if (result != null) Navigator.pop(dialogContext);
                      },
                      text: "Submit".tr,
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelBottomSheet(BuildContext context) {
    // Get the controller and ID needed for the API call
    final String bookingId = statusBooking?.id ?? '';

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
                text: AppStrings.confirmRideCancelAlert.tr,
                fontSize: 12.sp,
                color: Colors.red,
                textAlign: TextAlign.center,
                bottom: 20.h,
                maxLine: 5,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: AppColors.primaryColor, width: 1.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          AppStrings.cancel.tr,
                          style: TextStyle(color: AppColors.primaryColor, fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: SizedBox(
                      height: 44.h,
                      child: ElevatedButton(
                        onPressed: () async {

                          double finalAmount = calculateWithdrawAmount(
                              statusBooking?.price ?? 0,
                              statusBooking?.numberOfPeople ?? 0
                          );

                          // 2. Pass it via arguments
                          Get.toNamed(
                            AppRoutes.withdrawRequestScreen,
                            arguments: {
                              'totalAmount': finalAmount,
                              'bookingId': statusBooking!.id,
                            },
                          );

                          // Navigator.pop(context); // Close the bottom sheet
                          //
                          // // Update status to Cancelled
                          // bool success = await bookingController.updateBookingStatus(bookingId, "cancelled");
                          // if (success) {
                          //   Navigator.pop(context, true);
                          // }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
                          elevation: 0,
                        ),
                        child: Text(
                          AppStrings.yes.tr,
                          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 16.h),
            ],
          ),
        );
      },
    );
  }

  void _showChatConfirmation(BuildContext context, String participantId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.cardColor, // Adjusted to match your app theme
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(text: "Start Conversation".tr, fontSize: 18.sp, fontWeight: FontWeight.w600),
        content: CustomText(text: "Do you want to create a chat room with this user?".tr, fontSize: 14.sp, maxLine: 2),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(dialogContext),
                  text: "No".tr,
                  color: Colors.white,
                  broderColor: Colors.grey.shade300,
                  textColor: Colors.black,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Obx(() => CustomButton(
                  loading: chatController.isCreateLoading.value,
                  onTap: () async {
                    Navigator.pop(dialogContext);
                    bool success = await chatController.createChatRoom(participantId);
                    if (success) {
                      // Navigate to user inbox screen after successful chat creation
                      Get.offAllNamed(AppRoutes.userInboxScreen);
                    }
                  },
                  text: "Yes, Start".tr,
                )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}