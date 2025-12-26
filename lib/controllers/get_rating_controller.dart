import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/get_rating_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetRatingController extends GetxController {
  // Loading state
  var isLoading = false.obs;

  // Rating data
  var ratingsResponse = Rxn<RatingsResponse>();

  // Function to fetch ratings
  Future<void> fetchRatings({
    required String userId,
    required String type, // "author" or "user"
  }) async {
    isLoading.value = true;

    try {
      final String url = "${ApiConstants.getRecent}$userId/$type";
      final response = await ApiClient.getData(url);

      if (response.statusCode == 200) {
        // Assuming response.body is already a Map<String, dynamic>
        ratingsResponse.value = RatingsResponse.fromJson(response.body);
      } else {
        Fluttertoast.showToast(
          msg: response.statusText ?? 'Failed to fetch ratings',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white,
          fontSize: 14.0,
        );
      }

    } catch (e) {
      debugPrint("Ratings Fetch Error: $e");
      Fluttertoast.showToast(
        msg: 'Something went wrong while fetching ratings',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

