import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/driver_status_rides_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class DriverStatusRidesController extends GetxController {
  /// Loading states per tab
  RxBool isLoadingOpen = false.obs;
  RxBool isLoadingPending = false.obs;
  RxBool isLoadingComplete = false.obs;

  /// Data holders
  RxList<RideStaticsAttribute> openRides = <RideStaticsAttribute>[].obs;
  RxList<RideStaticsAttribute> pendingRides = <RideStaticsAttribute>[].obs;
  RxList<RideStaticsAttribute> completedRides = <RideStaticsAttribute>[].obs;

  /// Fetch rides by status
  Future<void> fetchRidesByStatus(String status) async {
    RxBool loading;
    RxList<RideStaticsAttribute> targetList;

    if (status == "open") {
      loading = isLoadingOpen;
      targetList = openRides;
    } else if (status == "pending") {
      loading = isLoadingPending;
      targetList = pendingRides;
    } else {
      loading = isLoadingComplete;
      targetList = completedRides;
    }

    loading.value = true;

    final response = await ApiClient.getData(
      ApiConstants.driverStatusRides + status,
    );

    if (response.statusCode == 201) {
      final model = DriverStatusRidesResponseModel.fromJson(response.body);
      targetList.assignAll(model.data?.attributes ?? []);
    } else {
      targetList.clear();
    }

    loading.value = false;
  }
}
