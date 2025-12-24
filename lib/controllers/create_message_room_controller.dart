import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../helpers/route.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'message_room_controller.dart';

class ChatController extends GetxController {
  RxBool isCreateLoading = false.obs;

  Future<void> createChatRoom(String participantId) async {
    isCreateLoading(true);

    Map<String, String> body = {
      "participantId": participantId,
    };

    try {
      var response = await ApiClient.postData(
        ApiConstants.driverRoomCreate,
        body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Fluttertoast.showToast(
          msg: "Chat room created successfully".tr,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );

        // 1. Refresh MessageRoomController so the new room is in the list
        if (Get.isRegistered<MessageRoomController>()) {
          await Get.find<MessageRoomController>().getMessageRooms();
        }

        // 2. Navigate to Driver Inbox (Tab 2)
        // We use offAllNamed to ensure the bottom bar resets to the Inbox state
        Get.offAllNamed(AppRoutes.driverInboxScreen, arguments: 2);

      } else {
        String errorMsg = response.body['message'] ?? "Failed to create room";
        Fluttertoast.showToast(msg: errorMsg, backgroundColor: Colors.red);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred".tr);
    } finally {
      isCreateLoading(false);
    }
  }
}