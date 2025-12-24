import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../models/single_ride_details_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SingleRideDetailsController extends GetxController {
  // Loading state
  RxBool isLoading = false.obs;
  RxBool isUpdating = false.obs;

  // Ride details data
  Rx<SingleRideDetailsModel?> rideDetails = Rx<SingleRideDetailsModel?>(null);

  /// Fetch single ride details by rideId
  Future<void> fetchRideDetails(String rideId) async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        "${ApiConstants.driverSingleRideDetails}$rideId",
      );

      if (response.statusCode == 200) {
        debugPrint("Ride Details Response: ${response.body}");
        // Parse the response to model
        rideDetails.value = SingleRideDetailsModel.fromJson(
          response.body['data']['attributes'] ?? {},
        );
      } else {
        rideDetails.value = null;
        debugPrint("Failed to fetch ride details: ${response.statusText}");
      }
    } catch (e) {
      rideDetails.value = null;
      debugPrint("Error fetching ride details: $e");
    } finally {
      isLoading.value = false;
    }
  }


  /// Update Ride Status (PATCH)
  Future<void> updateRideStatus(BuildContext context, String rideId, String status) async {
    isUpdating.value = true;

    Map<String, String> body = {
      "status": status,
    };

    try {
      final response = await ApiClient.patchData(
        "${ApiConstants.driverRideStatusUpdate}$rideId",
        jsonEncode(body),
      );

      // Check if the screen is still visible before using context
      if (!context.mounted) return;

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: CustomText(text: "Ride Update successfully".tr,color: AppColors.backgroundColor,), backgroundColor: Colors.green),
        );

        // Use Navigator.pop with 'true' to trigger the refresh in the previous screen
        Navigator.pop(context, true);
      } else {
        // Error Message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body['message'] ?? "Something went wrong"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("Error updating ride status: $e");
    } finally {
      isUpdating.value = false;
    }
  }
}
