import '../models/search_ride_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRideController extends GetxController {
  final isLoading = false.obs;
  final isDistanceLoading = false.obs;

  final RxString currentSearchType = 'pickup'.obs; // pickup | dropoff
  final RxList searchResults = <dynamic>[].obs;

  final RxList<RideAttribute> rides = <RideAttribute>[].obs;
  /// Vehicle
  final List<String> vehicleTypes = ['Bike', 'Car', 'Combi', 'Moto'];
  final selectedVehicle = ''.obs;

  /// Map data
  final Rx<LatLng?> pickupLatLng = Rx<LatLng?>(null);
  final Rx<LatLng?> dropoffLatLng = Rx<LatLng?>(null);

  final distanceKm = 0.obs;

  void clearSearchResults() {
    searchResults.clear();
  }

  Future<void> calculateDistance() async {
    if (pickupLatLng.value == null || dropoffLatLng.value == null) return;

    isDistanceLoading.value = true;

    final p1 = pickupLatLng.value!;
    final p2 = dropoffLatLng.value!;

    // Use a raw String for the URL
    final String googleUrl =
        "https://maps.googleapis.com/maps/api/distancematrix/json"
        "?origins=${p1.latitude},${p1.longitude}"
        "&destinations=${p2.latitude},${p2.longitude}"
        "&key=${ApiConstants.googleApiKey}";

    try {
      // IMPORTANT: Use http.get directly, NOT your ApiClient
      // This prevents your backend BaseURL from being added to the front
      final response = await http.get(Uri.parse(googleUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'OK') {
          var element = data['rows'][0]['elements'][0];

          if (element['status'] == 'OK') {
            int meters = element['distance']['value'];
            distanceKm.value = (meters / 1000).round();
            debugPrint('✅ Google Distance Success: ${distanceKm.value} km');
          } else {
            debugPrint('❌ Google Element Error: ${element['status']}');
          }
        } else {
          debugPrint('❌ Google Status Error: ${data['status']}');
        }
      } else {
        debugPrint('❌ Google API HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('❌ Google Distance API Exception: $e');
    } finally {
      isDistanceLoading.value = false;
    }
  }


  Future<void> searchPlaces(String query) async {
    debugPrint("🚀 Places search for: $query");
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    final url = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$query&key=${ApiConstants.googleApiKey}";
    try {
      final response = await http.get(Uri.parse(url));
      debugPrint("🔹 HTTP status: ${response.statusCode}");
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("🔹 API status: ${data['status']}");
        if (data['status'] == 'OK') {
          searchResults.assignAll(data['predictions']);
          debugPrint("🔹 Predictions found: ${data['predictions'].length}");
        } else {
          debugPrint("⚠️ Places API returned status: ${data['status']}");
        }
      }
    } catch (e) {
      debugPrint("❌ Places API Error: $e");
    }
  }


  Future<LatLng?> getLatLngFromAddress(String address) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?address=${Uri.encodeComponent(address)}&key=${ApiConstants.googleApiKey}";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'OK') {
          final loc = data['results'][0]['geometry']['location'];
          return LatLng(loc['lat'], loc['lng']);
        }
      }
    } catch (e) {
      debugPrint("Geocoding Error: $e");
    }
    return null;
  }


  Future<String> getAddressFromLatLng(LatLng position) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=${ApiConstants.googleApiKey}";

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'].isNotEmpty) {
          return data['results'][0]['formatted_address'];
        }
      }
    } catch (e) {
      debugPrint("Geocoding Error: $e");
    }

    // Fallback
    return "${position.latitude}, ${position.longitude}";
  }




  /// ================= Search Ride API =================
  Future<void> searchRide({
    required String date,
    required int passenger,
  }) async {
    if (pickupLatLng.value == null || dropoffLatLng.value == null) {
      debugPrint('❌ Search aborted: pickup/dropoff missing');
      return;
    }

    // --- NEW: Safety check for distance ---
    // If distance is still 0 but we have coordinates, try calculating it one last time
    if (distanceKm.value == 0) {
      debugPrint('⚠️ Distance is 0, attempting last-minute calculation...');
      await calculateDistance();
    }

    isLoading.value = true;

    final query = {
      "pickup":
      "${pickupLatLng.value!.longitude},${pickupLatLng.value!.latitude}",
      "dropoff":
      "${dropoffLatLng.value!.longitude},${dropoffLatLng.value!.latitude}",
      "date": date,
      "number_of_passenger": passenger.toString(),
      "distanceKm": distanceKm.value.toString(),
      "vehicleModel": selectedVehicle.value,
    };

    /// 🔍 LOG REQUEST
    debugPrint('================= SEARCH RIDE REQUEST =================');
    debugPrint('➡️ API: ${ApiConstants.baseUrl}${ApiConstants.searchRide}');
    debugPrint('➡️ Query Params:');
    query.forEach((key, value) {
      debugPrint('   $key : $value');
    });
    debugPrint('=======================================================');

    final response = await ApiClient.getData(
      ApiConstants.searchRide,
      query: query,
    );

    /// 🔍 LOG RESPONSE
    debugPrint('================= SEARCH RIDE RESPONSE =================');
    debugPrint('⬅️ Status Code: ${response.statusCode}');
    debugPrint('⬅️ Status Text: ${response.statusText}');
    debugPrint('⬅️ Raw Body:');
    debugPrint(response.bodyString ?? response.body.toString());
    debugPrint('========================================================');

    if (response.statusCode == 200) {
      try {
        final model = SearchRideModel.fromJson(response.body);
        rides.assignAll(model.data.attributes);

        debugPrint('✅ Parsed rides count: ${rides.length}');
      } catch (e) {
        debugPrint('❌ JSON Parse Error: $e');
        rides.clear();
      }
    } else {
      debugPrint('❌ API Error: ${response.statusCode}');
      rides.clear();
    }

    isLoading.value = false;
  }
}

