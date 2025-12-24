import 'package:shared_preferences/shared_preferences.dart';

import '../models/recent_search_model.dart';
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

  final RxList<RecentSearchModel> recentSearches = <RecentSearchModel>[].obs;
  final RxList<RideAttribute> rides = <RideAttribute>[].obs;
  /// Vehicle
  final List<String> vehicleTypes = ['Bike', 'Car', 'Combi', 'Moto'];
  final selectedVehicle = ''.obs;

  /// Map data
  final Rx<LatLng?> pickupLatLng = Rx<LatLng?>(null);
  final Rx<LatLng?> dropoffLatLng = Rx<LatLng?>(null);

  final distanceKm = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecentSearches(); // Load data when controller starts
  }

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




  Future<void> searchRide({
    required String date,
    required int passenger,
  }) async {
    if (pickupLatLng.value == null || dropoffLatLng.value == null) {
      debugPrint('❌ Search aborted: pickup/dropoff missing');
      return;
    }

    if (distanceKm.value == 0) {
      await calculateDistance();
    }

    isLoading.value = true;

    // This Map matches your Postman Raw JSON Body exactly
    final Map<String, dynamic> rawBody = {
      "pickup": [pickupLatLng.value!.longitude, pickupLatLng.value!.latitude],
      "dropoff": [dropoffLatLng.value!.longitude, dropoffLatLng.value!.latitude],
      "date": date,
      "number_of_passenger": passenger,
      "distanceKm": distanceKm.value.toInt(),
      "vehicleModel": selectedVehicle.value.toLowerCase(),
    };

    /// 🔍 LOG REQUEST
    debugPrint('================= SEARCH RIDE REQUEST (GET RAW BODY) =================');
    debugPrint('➡️ API: ${ApiConstants.baseUrl}${ApiConstants.searchRide}');
    debugPrint('➡️ Body: ${jsonEncode(rawBody)}');
    debugPrint('======================================================================');

    final response = await ApiClient.getData(
      ApiConstants.searchRide,
      query: rawBody, // Passed as the body now
    );

    if (response.statusCode == 200) {
      try {
        final model = SearchRideModel.fromJson(response.body);
        rides.assignAll(model.data.attributes);
        debugPrint('✅ Found ${rides.length} rides');
      } catch (e) {
        debugPrint('❌ JSON Parse Error: $e');
        rides.clear();
      }
    } else {
      debugPrint('❌ API Error: ${response.statusCode} - ${response.bodyString}');
      rides.clear();
    }
    isLoading.value = false;
  }



  // Save search to local storage
  Future<void> saveSearchLocally({required String pickup, required String dropoff, required String date, required int passengers}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Create new search object
    RecentSearchModel newSearch = RecentSearchModel(
      pickup: pickup,
      dropoff: dropoff,
      date: date,
      passengers: passengers,
    );

    // Add to top of list and keep only last 5 items
    recentSearches.insert(0, newSearch);
    if (recentSearches.length > 5) recentSearches.removeLast();

    // Convert list to JSON string and save
    List<String> jsonList = recentSearches.map((e) => jsonEncode(e.toJson())).toList();
    await prefs.setStringList('recent_searches', jsonList);
  }

  // Load searches from local storage
  Future<void> loadRecentSearches() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList('recent_searches');

    if (jsonList != null) {
      recentSearches.assignAll(
          jsonList.map((e) => RecentSearchModel.fromJson(jsonDecode(e))).toList()
      );
    }
  }

}

