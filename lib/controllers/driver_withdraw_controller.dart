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
  // Hold the balance passed from the wallet screen
  double totalAvailableBalance = 0.0;

  @override
  void onInit() {
    super.onInit();
    // Get the balance passed via Get.arguments
    totalAvailableBalance = Get.arguments ?? 0.0;
  }

  // Logic for "Withdraw All" button
  void setMaxAmount() {
    amountController.text = totalAvailableBalance.toStringAsFixed(0);
  }

  Future<void> requestWithdrawal() async {
    double enteredAmount = double.tryParse(amountController.text) ?? 0.0;

    // Validation Logic
    if (bankNameController.text.isEmpty ||
        accountNumberController.text.isEmpty ||
        accountTypeController.text.isEmpty ||
        amountController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all fields".tr, backgroundColor: Colors.red);
      return;
    }

    if (enteredAmount > totalAvailableBalance) {
      Fluttertoast.showToast(msg: "Insufficient balance".tr, backgroundColor: Colors.red);
      return;
    }

    if (enteredAmount <= 0) {
      Fluttertoast.showToast(msg: "Please enter a valid amount".tr, backgroundColor: Colors.red);
      return;
    }

    isLoading.value = true;
    try {
      final body = {
        "bankName": bankNameController.text,
        "accountNumber": accountNumberController.text,
        "accountType": accountTypeController.text,
        "totalAmount": amountController.text,
        "paymentType": "withdrawal"
      };

      var response = await ApiClient.postData(ApiConstants.withdrawRequest, body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        Fluttertoast.showToast(msg: "Withdraw Request submitted successfully!".tr, backgroundColor: Colors.green);
        Get.back();
      } else {
        Fluttertoast.showToast(msg: response.body['message'] ?? "Failed".tr, backgroundColor: Colors.red);
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