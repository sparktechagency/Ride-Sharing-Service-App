
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../models/recent_order_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class RecentOrderController extends GetxController {
  /// ======================> Loading State <======================
  final RxBool isLoading = false.obs;

  /// ======================> Data State <======================
  final Rx<RecentOrderResponseModel?> recentOrderResponse =
  Rx<RecentOrderResponseModel?>(null);

  final RxList<RecentOrderAttribute> recentOrders =
      <RecentOrderAttribute>[].obs;

  /// ======================> API Call <======================
  Future<void> getRecentOrders() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiConstants.getRecentOrder,
      );

      final body = response.body;

      if (response.statusCode == 201) {
        final parsedResponse =
        RecentOrderResponseModel.fromJson(body);

        recentOrderResponse.value = parsedResponse;
        recentOrders.assignAll(parsedResponse.data.attributes);

        /// ✅ API success message
        Fluttertoast.showToast(
          msg: parsedResponse.message,
          toastLength: Toast.LENGTH_SHORT,
        );
      } else {
        /// ✅ API error message (no manual text)
        Fluttertoast.showToast(
          msg: body['message'] ?? '',
          toastLength: Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      debugPrint('RecentOrder Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// ======================> Lifecycle <======================
  @override
  void onInit() {
    super.onInit();
    getRecentOrders();
  }
}
