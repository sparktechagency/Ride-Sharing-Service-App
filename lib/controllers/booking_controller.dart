import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ride_sharing/utils/app_constants.dart';

import '../helpers/prefs_helpers.dart';
import '../models/booking_update_model.dart';
import '../models/booking_user_details_model.dart';
import '../models/booking_with_status_model.dart';
import '../models/create_booking_response_model.dart';
import '../service/api_client.dart';
import 'package:get/get.dart';

import '../service/api_constants.dart';

class BookingController extends GetxController {
  /// =================== COMMON STATES ===================
  final isLoadingUser = false.obs;
  final isLoadingBooking = false.obs;
  final errorMessage = ''.obs;

  final isUpdatingStatus = false.obs;
  final shouldSwitchToCancelledTab = false.obs;

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
  /// CREATE BOOKING
  /// ===================================================
  Future<CreateBookingAttributes?> createBooking({
    required String driverId,
    required int price,
    required int numberOfPeople,
    required String vehicleType,
    required CreateBookingLocationInfo pickUp,
    required CreateBookingLocationInfo dropOff,
    required String rideDate,
    required String rideId,
  }) async {
    try {
      isLoadingBooking(true);
      errorMessage('');

      // 1. Prepare the Body Map with proper types
      final Map<String, dynamic> body = {
        "driverId": driverId,
        "price": price,
        "number_of_people": numberOfPeople,
        "vehicle_type": vehicleType,
        "pickUp": {
          "address": pickUp.address,
          "location": {
            "type": pickUp.location?.type ?? "Point",
            "coordinates": pickUp.location?.coordinates ?? [],
          }
        },
        "dropOff": {
          "address": dropOff.address,
          "location": {
            "type": dropOff.location?.type ?? "Point",
            "coordinates": dropOff.location?.coordinates ?? [],
          }
        },
        "ride_date": rideDate,
        "ride_id": rideId,
      };

      // 2. Fetch the token manually to build custom headers
      String bearerToken = await PrefsHelper.getString(AppConstants.bearerToken);

      // 3. Define JSON headers to override the default ones in postData
      Map<String, String> jsonHeaders = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $bearerToken',
      };

      /// =================== API CALL ===================
      final response = await ApiClient.postData(
        ApiConstants.createBooking,
        jsonEncode(body), // Encode body to JSON string here
        headers: jsonHeaders, // Pass the custom headers here
      );

      debugPrint("Response : $response");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final model = CreateBookingResponseModel.fromJson(response.body);
        return model.data?.attributes;
      } else {
        errorMessage(response.statusText ?? 'Failed to create booking');
        return null;
      }
    } catch (e) {
      debugPrint("The real error is: $e");
      errorMessage("Connection error: Please try again later.");
      return null;
    } finally {
      isLoadingBooking(false);
    }
  }


  /// ===================================================
  /// CLEAR DATA (OPTIONAL)
  /// ===================================================
  void clearBookings() {
    bookings.clear();
  }
}
