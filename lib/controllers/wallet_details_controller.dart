
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../models/get_wallet_details_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';

class WalletDetailsController extends GetxController {
  // Loading states
  RxBool isLoading = false.obs;
  RxBool isLoadingWallet = false.obs;
  RxBool isLoadingTransactions = false.obs;

  // Wallet details data
  Rx<GetWalletDetailsResponseModel?> walletDetails = Rx<GetWalletDetailsResponseModel?>(null);

  /// Fetch wallet details for driver
  Future<void> fetchWalletDetails() async {
    isLoading.value = true;

    try {
      final response = await ApiClient.getData(
        ApiConstants.driverWalletDetails,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint("Wallet Details Response: ${response.body}");
        
        // Parse the response to model
        walletDetails.value = GetWalletDetailsResponseModel.fromJson(
          response.body,
        );
      } else {
        walletDetails.value = null;
        debugPrint("Failed to fetch wallet details: ${response.statusText}");
        // Optionally show error message to user
        Get.snackbar(
          "Error",
          "Failed to load wallet details: ${response.statusText}",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      walletDetails.value = null;
      debugPrint("Error fetching wallet details: $e");
      Get.snackbar(
        "Error",
        "An unexpected error occurred: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Get wallet summary (earnings and withdrawals)
  Wallet? getWalletSummary() {
    return walletDetails.value?.data?.attributes?.wallet;
  }

  /// Get transaction list
  List<Transaction>? getTransactions() {
    return walletDetails.value?.data?.attributes?.transaction;
  }

  /// Get total earnings
  double getTotalEarnings() {
    return walletDetails.value?.data?.attributes?.wallet?.totalEarnings ?? 0.0;
  }

  /// Get total withdrawals
  double getTotalWithdrawals() {
    return walletDetails.value?.data?.attributes?.wallet?.totalWithDrawal ?? 0.0;
  }

  /// Get net balance (earnings - withdrawals)
  double getNetBalance() {
    final wallet = walletDetails.value?.data?.attributes?.wallet;
    if (wallet != null) {
      return (wallet.totalEarnings ?? 0.0) - (wallet.totalWithDrawal ?? 0.0);
    }
    return 0.0;
  }

  /// Get transaction count
  int getTransactionCount() {
    return walletDetails.value?.data?.attributes?.transaction?.length ?? 0;
  }

  /// Refresh wallet data
  Future<void> refreshWalletData() async {
    await fetchWalletDetails();
  }

  /// Get recent transactions (limit to last N transactions)
  List<Transaction> getRecentTransactions({int limit = 5}) {
    final transactions = walletDetails.value?.data?.attributes?.transaction;
    if (transactions != null && transactions.isNotEmpty) {
      // Sort by date (newest first) and return limited results
      transactions.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
      return transactions.length > limit 
          ? transactions.sublist(0, limit) 
          : transactions;
    }
    return [];
  }
}