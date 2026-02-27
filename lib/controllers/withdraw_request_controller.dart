import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../helpers/route.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'booking_controller.dart';


class WithdrawRequestController extends GetxController {
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTypeController = TextEditingController();

  var isLoading = false.obs;
  double totalAmount = 0.0;
  String bookingId = '';

  @override
  void onInit() {
    super.onInit();
    // Receive data from the Ride Details screen
    totalAmount = Get.arguments?['totalAmount'] ?? 0.0;
    bookingId = Get.arguments?['bookingId'] ?? '';
  }

  Future<void> submitWithdrawRequest() async {
    // 1. Basic Validation
    if (bankNameController.text.isEmpty ||
        accountNumberController.text.isEmpty ||
        accountTypeController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields".tr, backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    try {
      // 2. Prepare the Body
      final body = {
        "bankName": bankNameController.text,
        "accountNumber": accountNumberController.text,
        "accountType": accountTypeController.text,
        "totalAmount": totalAmount.toString(),
        "paymentType": "cancelled"
      };

      // 3. Prepare the URL with the Query Parameter
      // This combines the endpoint with ?cancelledId=YOUR_ID
      String urlWithParams = "${ApiConstants.withdrawRequest}?cancelledId=$bookingId";

      // 4. Hit the Single API
      var response = await ApiClient.postData(urlWithParams, body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Withdraw Request Created successfully!".tr,
            backgroundColor: Colors.green
        );

        // 5. Refresh the Booking Lists and set flag to switch to cancelled tab
        if (Get.isRegistered<BookingController>()) {
          final bookingController = Get.find<BookingController>();
          bookingController.getBookingsByStatus("pending");
          bookingController.getBookingsByStatus("cancelled");
          // Set flag to switch to cancelled tab after navigation
          bookingController.shouldSwitchToCancelledTab.value = true;
        }

        // 6. Navigate back to Main Tab Screen
        Get.until((route) => Get.currentRoute == AppRoutes.myRidesScreen);
      } else {
        Fluttertoast.showToast(
            msg: response.body['message'] ?? "Failed to submit request".tr,
            backgroundColor: Colors.red
        );
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e", backgroundColor: Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    bankNameController.dispose();
    accountNumberController.dispose();
    accountTypeController.dispose();
    super.onClose();
  }
}
