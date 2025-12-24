import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../service/api_client.dart';
import '../service/api_constants.dart';

class ChatController extends GetxController {
  RxBool isCreateLoading = false.obs;

  //=============================> Create Chat Room <===============================
  Future<void> createChatRoom(String participantId) async {
    isCreateLoading(true);

    // Body formatted as x-www-form-urlencoded as per your mainHeaders requirement
    Map<String, String> body = {
      "participantId": participantId,
    };

    try {
      var response = await ApiClient.postData(
        ApiConstants.driverRoomCreate,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success case
        Fluttertoast.showToast(
          msg: "Chat room created successfully".tr,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // Navigation or further logic (e.g., Get.toNamed(AppRoutes.chatDetail))
      } else {
        // Failure case: Uses the message from the API (like "One or both participants do not exist")
        String errorMsg = response.body['message'] ?? "Failed to create room";

        Fluttertoast.showToast(
          msg: errorMsg,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }
    } catch (e) {
      debugPrint("Create Room Error: $e");
      Fluttertoast.showToast(
        msg: "An unexpected error occurred".tr,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      isCreateLoading(false);
    }
  }
}