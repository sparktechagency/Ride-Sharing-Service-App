import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/controllers/profile_controller.dart';
import '../helpers/route.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'package:flutter/material.dart';

class LicenseUploadController extends GetxController {
  var imagePaths = List<String>.filled(2, '').obs;
  var uploadGalleryLoading = false.obs;

  Future<void> uploadLicenseImages() async {
    final front = imagePaths[0];
    final back = imagePaths[1];

    if (front.isEmpty || back.isEmpty) {
      Fluttertoast.showToast(
        msg: 'Both front and back images are required.'.tr,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      return;
    }

    uploadGalleryLoading.value = true;
    update();

    try {
      // Logic: Use MultipartBody to send the files
      List<MultipartBody> multipartBody = [
        MultipartBody('image', File(front)),
        MultipartBody('image', File(back)),
      ];

      var response = await ApiClient.postMultipartData(
        ApiConstants.driverLicenseUploadEndPoint,
        {},
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Reset the local paths
        imagePaths.assignAll(List.filled(2, ''));

        // 2. Check if we came from Personal Information Screen via arguments
        bool isFromProfile = Get.arguments != null && Get.arguments['isFromProfile'] == true;

        if (isFromProfile) {
          // Success Feedback using Fluttertoast
          Fluttertoast.showToast(
            msg: "License Updated Successfully".tr,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
          );

          // 3. Refresh Profile Data so the Information Screen shows new images
          if (Get.isRegistered<ProfileController>()) {
            await Get.find<ProfileController>().getProfileData();
          }

          // 4. Navigate back to PersonalInformationScreen
          Get.back();
        } else {
          // Default behavior (Initial Registration flow)
          Fluttertoast.showToast(
            msg: "Upload Successful".tr,
            backgroundColor: Colors.green,
            textColor: Colors.white,
          );
          Get.offAllNamed(AppRoutes.driverHomeScreen);
        }
      } else {
        ApiChecker.checkApi(response);
      }
    } catch (e) {
      debugPrint("Upload Error: $e");
      Fluttertoast.showToast(
        msg: "Upload Error: ${e.toString()}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      // Always stop loading regardless of success or failure
      uploadGalleryLoading.value = false;
      update();
    }
  }}