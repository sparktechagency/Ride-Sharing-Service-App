import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_network_image.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../../../../../../controllers/create_message_room_controller.dart';
import '../../../../../../controllers/rating_controller.dart';
import '../../../../../../controllers/single_ride_details_controller.dart';
import '../../../../../../models/single_ride_details_model.dart';

class SingleRideDetailsScreen extends StatelessWidget {
  final String rideId;
  final SingleRideDetailsController controller = Get.put(SingleRideDetailsController());
  final ChatController chatController = Get.put(ChatController());

  SingleRideDetailsScreen({super.key, required this.rideId}) {
    controller.fetchRideDetails(rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black, onPressed: () => Get.back()),
        title: Text("Details", style: TextStyle(color: Colors.black, fontSize: 18.sp)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.rideDetails.value;
        if (data == null) {
          return Center(child: Text("No Details Found", style: TextStyle(fontSize: 16.sp)));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTripCard(context, data),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total User (${data.bookingUsers.length.toString().padLeft(2, '0')})",
                    style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("See all", style: TextStyle(color: Colors.grey, fontSize: 14.sp))
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.bookingUsers.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  // Pass status here
                  return _buildUserTile(context,data.bookingUsers[index], data.status);
                },
              ),
            ],
          ),
        );
      }),
      floatingActionButton: Obx(() => FloatingActionButton(
        onPressed: chatController.isCreateLoading.value
            ? null
            : () {
          final data = controller.rideDetails.value;
          if (data != null) {
            // Show confirmation before starting chat
            _showChatConfirmation(context, rideId); // Assuming userId is the participant
          }
        },
        backgroundColor: chatController.isCreateLoading.value
            ? Colors.grey
            : AppColors.primaryColor,
        child: chatController.isCreateLoading.value
            ? SizedBox(
            height: 20.h,
            width: 20.w,
            child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
        )
            : Icon(Icons.chat_bubble_outline, color: AppColors.backgroundColor, size: 24.w),
      )),
    );
  }

  Widget _buildTripCard(BuildContext context, SingleRideDetailsModel data) {
    String buttonText = "";
    String nextStatus = "";
    bool showButton = true;
    bool isClickable = true; // Tracks if the button should be active

    String currentStatus = data.status.toLowerCase();

    if (currentStatus == "pending") {
      buttonText = "Start Trip";
      nextStatus = "open";
    } else if (currentStatus == "open") {
      buttonText = "Complete Trip";
      nextStatus = "complete";
    } else if (currentStatus == "complete") {
      buttonText = "Completed"; // Text requested
      isClickable = false;      // Make non-clickable
      showButton = true;
    } else {
      showButton = false;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Column(
        children: [
          // ======================== Header ========================
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today ${DateFormat('hh:mm a').format(data.createdAt)}",
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColors.primaryColor),
                  ),
                  child: Text(
                    data.status,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1),

          // ======================== Route Information ========================
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Column(
                  children: [
                    Icon(Icons.radio_button_off, color: Colors.green, size: 20.w),
                    Container(width: 2.w, height: 40.h, color: Colors.grey.shade300),
                    Icon(Icons.location_on, color: Colors.red, size: 20.w),
                  ],
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.pickUp.address,
                        style: TextStyle(color: Colors.black87, fontSize: 13.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 25.h),
                      Text(
                        data.dropOff.address,
                        style: TextStyle(color: Colors.black87, fontSize: 13.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1),

          // ======================== Seat & Price Details ========================
          _infoRow("Total Passengers Seat :", "${data.totalPassenger} Person"),
          _infoRow("Booking Seat :", "${data.seatsBooked.toString().padLeft(2, '0')} Person"),
          const Divider(height: 1),
          _infoRow("Available Seat :", "${data.totalPassenger - data.seatsBooked} Seat"),
          _infoRow("Per Seat Price :", "\$ ${data.pricePerSeat}", isPrice: true),

          // ======================== Dynamic Action Button ========================
          if (showButton)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Obx(() => CustomButton(
                // If not clickable, onTap is null (disables button)
                onTap: isClickable
                    ? () => _showConfirmationDialog(context, buttonText, nextStatus)
                    : () {}, // Pass an empty function instead of null
                text: buttonText,
                // Optional: You can change color to grey if isClickable is false
                color: isClickable ? AppColors.primaryColor : Colors.grey.shade400,
                loading: controller.isUpdating.value,
              )),
            ),

          if (!showButton) SizedBox(height: 16.h),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String actionTitle, String status) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundColor, // Set requested background
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(
            text: actionTitle,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600
        ),
        content: CustomText(
          text: "Are you sure you want to $actionTitle?",
          fontSize: 14.sp,
          maxLine: 2,
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(dialogContext),
                  text: "Cancel",
                  color: Colors.grey.shade200,
                  textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Navigator.pop(dialogContext);
                    controller.updateRideStatus(context, rideId, status);
                  },
                  text: "Confirm",
                  textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _infoRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.black87, fontSize: 15.sp)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isPrice ? 20.sp : 15.sp,
              color: isPrice ? AppColors.primaryColor : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(BuildContext context, BookingUser user, String rideStatus) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column( // Changed to column to allow button below
        children: [
          Row(
            children: [
              Container(
                width: 50.w, height: 50.h,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                  image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Text("Location: ", style: TextStyle(fontSize: 12.sp, color: Colors.grey)),
                        Text("Dhaka", style: TextStyle(fontSize: 12.sp)),
                        Icon(Icons.arrow_right_alt, size: 16.w, color: Colors.grey),
                        Text("Mirpur 10", style: TextStyle(fontSize: 12.sp)),
                      ],
                    ),
                  ],
                ),
              ),
              Text("4.8", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
              Icon(Icons.star, color: Colors.amber, size: 20.w),
            ],
          ),

          // Inside _buildUserTile method
          if (rideStatus.toLowerCase() == "complete")
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: CustomButton(
                  onTap: () {
                    // Trigger the review dialog
                    _showReviewDialog(context, user);
                  },
                  width: 100.w,
                  height: 30.h,
                  text: "Give Review",
                  textStyle: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }


  void _showReviewDialog(BuildContext context, BookingUser user) {
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
              // OK Icon
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.check_circle, color: Colors.green, size: 40.w),
              ),
              SizedBox(height: 16.h),

              CustomText(
                text: "Give Person rating out of 5!",
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(height: 20.h),


              SizedBox(height: 8.h),
              CustomText(text: user.userName, fontSize: 16.sp, fontWeight: FontWeight.w600),
              SizedBox(height: 16.h),

              // Star Rating
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => selectedStars.value = index + 1,
                    icon: Icon(
                      index < selectedStars.value ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32.w,
                    ),
                  );
                }),
              )),
              SizedBox(height: 16.h),

              // Feedback TextField
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(text: "Write your feedback", fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextField(
                controller: feedbackController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: "Type here...",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
                  filled: true,
                  fillColor: Colors.grey.shade50,
                ),
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      onTap: () => Navigator.pop(dialogContext),
                      text: "Cancel",
                      color: Colors.grey.shade200,
                      textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Obx(() => CustomButton(
                      loading: ratingController.isLoading.value,
                      // Inside _showReviewDialog's Submit Button
                      onTap: () async {
                        if (selectedStars.value == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Please select stars"))
                          );
                          return;
                        }

                        final result = await ratingController.createRating(
                          context: context, // Passing the context here
                          ride: rideId,
                          target_id: user.id.toString(),
                          stars: selectedStars.value,
                          review: feedbackController.text,
                        );

                        if (result != null) {
                          Navigator.pop(dialogContext); // Close dialog on success
                        }
                      },
                      text: "Submit",
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


  // 3. Chat Confirmation Dialog
  void _showChatConfirmation(BuildContext context, String participantId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        title: CustomText(
            text: "Start Conversation",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600
        ),
        content: CustomText(
          text: "Do you want to create a chat room with the ride participant?",
          fontSize: 14.sp,
          maxLine: 2,
        ),
        actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  onTap: () => Navigator.pop(dialogContext),
                  text: "No",
                  color: Colors.grey.shade200,
                  textStyle: TextStyle(color: Colors.black, fontSize: 14.sp),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  onTap: () {
                    Navigator.pop(dialogContext);
                    // Call the createChatRoom method from ChatController
                    chatController.createChatRoom(participantId);
                  },
                  text: "Yes, Start",
                  textStyle: TextStyle(color: Colors.white, fontSize: 14.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}