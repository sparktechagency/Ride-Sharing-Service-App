import 'dart:convert';

import 'package:ride_sharing/utils/app_constants.dart';

import '../models/booking_update_model.dart';
import '../models/booking_user_details_model.dart';
import '../models/booking_with_status_model.dart';
import '../service/api_client.dart';
import 'package:get/get.dart';

import '../service/api_constants.dart';

class BookingController extends GetxController {
  /// =================== COMMON STATES ===================
  final isLoadingUser = false.obs;
  final isLoadingBooking = false.obs;
  final errorMessage = ''.obs;

  final isUpdatingStatus = false.obs;

  /// =================== USER DETAILS ===================
  final userDetails = Rxn<BookingUserAttributes>();

  /// =================== BOOKINGS ===================
  final bookings = <BookingAttribute>[].obs;

  /// ===================================================
  /// GET BOOKING USER DETAILS
  /// ===================================================
  Future<void> getBookingUserDetails(String userId) async {
    try {
      isLoadingUser(true);
      errorMessage('');

      final response = await ApiClient.getData(
          "${ApiConstants.getBookingUserDetails}$userId"
      );

      if (response.statusCode == 201) {
        final model = BookingUserDetails.fromJson(response.body);
        userDetails.value = model.data?.attributes;
      } else {
        errorMessage(response.statusText ?? 'Failed to load user details');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoadingUser(false);
    }
  }

  /// ===================================================
  /// GET BOOKINGS BY STATUS
  /// ===================================================
  Future<void> getBookingsByStatus(String status) async {
    try {
      isLoadingBooking(true);
      errorMessage('');

      final response = await ApiClient.getData(
          "${ApiConstants.getBookingByStatus}$status"
      );

      if (response.statusCode == 201) {
        final model = BookingWithStatusModel.fromJson(response.body);
        bookings.assignAll(model.data.attributes);
      } else {
        errorMessage(response.statusText ?? 'Failed to load bookings');
      }
    } catch (e) {
      errorMessage(e.toString());
    } finally {
      isLoadingBooking(false);
    }
  }


  Future<bool> updateBookingStatus(String bookingId, String newStatus) async {
    try {
      isUpdatingStatus(true);

      Map<String, String> body = {"status": newStatus};

      final response = await ApiClient.patchData(
        "${ApiConstants.updateStatus}$bookingId",
        jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // 1. Find the item in the current observable list
        int index = bookings.indexWhere((element) => element.id == bookingId);

        if (index != -1) {
          // 2. REMOVE the item from the current list immediately
          // This ensures the "Ongoing" tab list clears that specific ride.
          bookings.removeAt(index);
          bookings.refresh(); // Forces Obx to update the UI
        }

        print("Update Success");
        return true;
      } else {
        errorMessage(response.statusText ?? 'Failed to update status');
        return false;
      }
    } catch (e) {
      errorMessage(e.toString());
      return false;
    } finally {
      isUpdatingStatus(false);
    }
  }

  /// ===================================================
  /// CLEAR DATA (OPTIONAL)
  /// ===================================================
  void clearBookings() {
    bookings.clear();
  }
}
