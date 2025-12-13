import 'package:ride_sharing/utils/app_constants.dart';

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

  /// ===================================================
  /// CLEAR DATA (OPTIONAL)
  /// ===================================================
  void clearBookings() {
    bookings.clear();
  }
}
