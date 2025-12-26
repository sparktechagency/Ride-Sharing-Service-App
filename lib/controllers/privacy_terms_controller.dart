import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/privacy_policy_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class PrivacyTermsController extends GetxController {
  // Loading states
  RxBool isLoadingPrivacyPolicy = false.obs;
  RxBool isLoadingTermsConditions = false.obs;

  // Data storage
  Rx<PrivacyPolicyModel?> privacyPolicy = Rx<PrivacyPolicyModel?>(null);
  Rx<PrivacyPolicyModel?> termsConditions = Rx<PrivacyPolicyModel?>(null);

  /// Fetch privacy policy
  Future<void> fetchPrivacyPolicy() async {
    isLoadingPrivacyPolicy.value = true;

    try {
      final response = await ApiClient.getData(
        ApiConstants.privacyPolicyEndPoint,
      );

      if (response.statusCode == 200) {
        debugPrint("Privacy Policy Response: ${response.body}");
        
        // Parse the response to model
        privacyPolicy.value = PrivacyPolicyModel.fromJson(
          response.body,
        );
      } else {
        privacyPolicy.value = null;
        debugPrint("Failed to fetch privacy policy: ${response.statusText}");
        // Optionally show error message to user
        Get.snackbar(
          "Error",
          "Failed to load privacy policy: ${response.statusText}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      privacyPolicy.value = null;
      debugPrint("Error fetching privacy policy: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingPrivacyPolicy.value = false;
    }
  }

  /// Fetch terms and conditions
  Future<void> fetchTermsConditions() async {
    isLoadingTermsConditions.value = true;

    try {
      final response = await ApiClient.getData(
        ApiConstants.termsConditionEndPoint,
      );

      if (response.statusCode == 200) {
        debugPrint("Terms & Conditions Response: ${response.body}");
        
        // Parse the response to model
        termsConditions.value = PrivacyPolicyModel.fromJson(
          response.body,
        );
      } else {
        termsConditions.value = null;
        debugPrint("Failed to fetch terms & conditions: ${response.statusText}");
        // Optionally show error message to user
        Get.snackbar(
          "Error",
          "Failed to load terms & conditions: ${response.statusText}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      termsConditions.value = null;
      debugPrint("Error fetching terms & conditions: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoadingTermsConditions.value = false;
    }
  }

  /// Get privacy policy content
  String getPrivacyPolicyContent() {
    return privacyPolicy.value?.data?.attributes?.content ?? '';
  }

  /// Get terms and conditions content
  String getTermsConditionsContent() {
    return termsConditions.value?.data?.attributes?.content ?? '';
  }

  /// Get privacy policy creation date
  DateTime? getPrivacyPolicyCreatedAt() {
    return privacyPolicy.value?.data?.attributes?.createdAt;
  }

  /// Get terms and conditions creation date
  DateTime? getTermsConditionsCreatedAt() {
    return termsConditions.value?.data?.attributes?.createdAt;
  }

  /// Get privacy policy updated date
  DateTime? getPrivacyPolicyUpdatedAt() {
    return privacyPolicy.value?.data?.attributes?.updatedAt;
  }

  /// Get terms and conditions updated date
  DateTime? getTermsConditionsUpdatedAt() {
    return termsConditions.value?.data?.attributes?.updatedAt;
  }

  /// Check if privacy policy data is available
  bool hasPrivacyPolicy() {
    return privacyPolicy.value?.data?.attributes?.content != null && 
           privacyPolicy.value!.data!.attributes!.content!.isNotEmpty;
  }

  /// Check if terms and conditions data is available
  bool hasTermsConditions() {
    return termsConditions.value?.data?.attributes?.content != null && 
           termsConditions.value!.data!.attributes!.content!.isNotEmpty;
  }

  /// Refresh privacy policy data
  Future<void> refreshPrivacyPolicy() async {
    await fetchPrivacyPolicy();
  }

  /// Refresh terms and conditions data
  Future<void> refreshTermsConditions() async {
    await fetchTermsConditions();
  }

  /// Get all privacy policy data
  PrivacyPolicyAttributes? getPrivacyPolicyAttributes() {
    return privacyPolicy.value?.data?.attributes;
  }

  /// Get all terms and conditions data
  PrivacyPolicyAttributes? getTermsConditionsAttributes() {
    return termsConditions.value?.data?.attributes;
  }
}