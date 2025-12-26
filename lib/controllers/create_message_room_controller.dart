import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import '../helpers/route.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'message_room_controller.dart';

class ChatController extends GetxController {
  RxBool isCreateLoading = false.obs;

  Future<bool> createChatRoom(String participantId) async {
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

        return true;
      } else {
        String errorMsg = response.body['message'] ?? "Failed to create room";
        Fluttertoast.showToast(msg: errorMsg, backgroundColor: Colors.red);
        return false;
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "An unexpected error occurred".tr);
      return false;
    } finally {
      isCreateLoading(false);
    }
  }
}