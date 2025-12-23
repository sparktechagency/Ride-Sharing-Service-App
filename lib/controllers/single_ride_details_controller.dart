import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/single_ride_details_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class SingleRideDetailsController extends GetxController {
  // Loading state
  RxBool isLoading = false.obs;

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
}
