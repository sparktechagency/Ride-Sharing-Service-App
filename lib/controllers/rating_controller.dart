import 'package:get/get.dart';

import '../models/rating_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class RatingController extends GetxController {
  var isLoading = false.obs;
  CreateRatingResponse? createRatingResponse;

  Future<CreateRatingResponse?> createRating({
    required String ride,
    required String target_id,
    required int stars,
    required String review,
  }) async {
    isLoading.value = true;

    try {
      /// 🔹 BODY (UNCHANGED as you requested)
      final body = {
        "ride": ride,
        "target_id": target_id,
        "stars": stars,
        "review": review,
      };

      Response response = await ApiClient.postData(
        ApiConstants.createRating,
        body,
      );

      if (response.statusCode == 201) {
        createRatingResponse =
            CreateRatingResponse.fromJson(response.body);
        return createRatingResponse;
      } else {
        Get.snackbar(
          "Error",
          response.statusText ?? "Something went wrong",
        );
        return null;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
