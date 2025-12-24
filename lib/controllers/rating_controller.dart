import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../models/rating_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class RatingController extends GetxController {
  var isLoading = false.obs;
  CreateRatingResponse? createRatingResponse;

  Future<CreateRatingResponse?> createRating({
    required BuildContext context, // Added context for ScaffoldMessenger
    required String ride,
    required String target_id,
    required int stars,
    required String review,
  }) async {
    isLoading.value = true;

    try {
      /// 🔹 BODY
      /// We convert 'stars' to String to prevent "int is not a subtype of String" error
      /// when using x-www-form-urlencoded headers.
      final body = {
        "ride": ride,
        "target_id": target_id,
        "stars": stars.toString(),
        "review": review,
      };

      Response response = await ApiClient.postData(
        ApiConstants.createRating,
        body,
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        createRatingResponse = CreateRatingResponse.fromJson(response.body);

        // Success Message using ScaffoldMessenger
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: CustomText(text: "Rating submitted successfully!", color:  AppColors.backgroundColor,),
              backgroundColor: Colors.green,
            ),
          );
        }
        return createRatingResponse;
      } else {
        // Error Message using ScaffoldMessenger
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.body['message'] ?? "Failed to submit rating"),
              backgroundColor: Colors.red,
            ),
          );
        }
        return null;
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}