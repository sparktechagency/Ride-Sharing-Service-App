import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../helpers/prefs_helpers.dart';
import '../service/api_checker.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';

class HomeController extends GetxController implements GetxService {

  String title = "Home Screen";

  @override
  void onInit() {
    debugPrint("On Init $title");
    super.onInit();
  }

  @override
  void onReady() {
    debugPrint("On onReady $title");
    super.onReady();
  }

  var isLoading = false.obs;
  var statisticsData = <String, dynamic>{}.obs;

  Future<void> fetchStatistics() async {
    isLoading.value = true;

    final token = await PrefsHelper.getString(AppConstants.bearerToken);
    if (token == null) {
      Get.snackbar('Error', 'No auth token found');
      isLoading.value = false;
      return;
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    Response response = await ApiClient.getData(
      ApiConstants.homePageStatisticsEndPoint,
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      statisticsData.value = response.body;
      print('✅ Statistics: ${response.body}');
    } else {
      ApiChecker.checkApi(response);
    }

    isLoading.value = false;
  }
}