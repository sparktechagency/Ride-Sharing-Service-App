import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/controllers/wallet_details_controller.dart';

import '../service/api_client.dart';
import '../service/api_constants.dart';

class DriverWithdrawController extends GetxController {
  final bankNameController = TextEditingController();
  final accountNumberController = TextEditingController();
  final accountTypeController = TextEditingController();
  final amountController = TextEditingController();

  var isLoading = false.obs;

  Future<void> requestWithdrawal() async {
    // Basic Validation
    if (bankNameController.text.isEmpty ||
        accountNumberController.text.isEmpty ||
        accountTypeController.text.isEmpty ||
        amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields".tr, backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;

    try {
      final body = {
        "bankName": bankNameController.text,
        "accountNumber": accountNumberController.text,
        "accountType": accountTypeController.text,
        "totalAmount": amountController.text,
        "paymentType": "withdrawal" // Fixed as requested
      };

      // Hit the withdrawal endpoint
      var response = await ApiClient.postData(ApiConstants.withdrawRequest, body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "Withdraw Request submitted successfully!".tr,
            backgroundColor: Colors.green
        );

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
    amountController.dispose();
    super.onClose();
  }
}