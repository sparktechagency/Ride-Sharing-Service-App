import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import 'package:ride_sharing/views/screen/Role/Driver/rider_post_submit/rider_post_submit.dart';

import '../helpers/prefs_helpers.dart';
import '../helpers/route.dart';
import '../models/create_ride_response_model.dart';
import '../service/api_client.dart';
import '../service/api_constants.dart';
import '../utils/app_constants.dart';
import '../views/screen/Role/Driver/AddCity/add_city_screen.dart';

import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// Ensure this model is defined only once in your project
class Stopover {
  final String name;
  final LatLng latLng;
  Stopover({required this.name, required this.latLng});
}

class PostRideController extends GetxController {
  // --- UI Text Controllers ---
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  var isPublishing = false.obs;
  // --- Location Observables ---
  var pickupLatLng = Rxn<LatLng>();
  var destinationLatLng = Rxn<LatLng>();
  var pickupAddress = ''.obs;
  var destinationAddress = ''.obs;

  // --- Ride Detail Observables ---
  var stopovers = <Stopover>[].obs;
  var selectedDate = DateTime.now().obs;
  var availableSeats = 1.obs;
  var estimatedPrice = 0.0.obs; // This acts as pricePerSeat in your UI

  // --- Route & Calculation Observables ---
  var polylinePoints = <LatLng>[].obs;
  var fullRoutePoints = <LatLng>[].obs;
  var routeBounds = Rxn<LatLngBounds>();
  var distanceText = '0 km'.obs;
  var durationText = ''.obs;
  var mainRoadName = 'Unknown Road'.obs;
  var hasTolls = false.obs;
  var isLoadingRoute = false.obs;
  var isFormValid = false.obs;

  final String googleApiKey = "AIzaSyCrmEOP4JyFCozu7n85BIZqn_8LarJq_iI";

  @override
  void onInit() {
    super.onInit();
    // Automatically fetch route whenever pickup or destination changes
    ever(pickupLatLng, (_) => _tryFetchRoute());
    ever(destinationLatLng, (_) => _tryFetchRoute());
  }

  void setLocation({required String type, required String address, required LatLng latLng}) {
    if (type == 'pickup') {
      pickupController.text = address;
      pickupAddress.value = address;
      pickupLatLng.value = latLng;
    } else {
      destinationController.text = address;
      destinationAddress.value = address;
      destinationLatLng.value = latLng;
    }
  }

  void _tryFetchRoute() {
    if (pickupLatLng.value != null && destinationLatLng.value != null) {
      fetchRealRoute();
    } else {
      _resetRoute();
    }
  }

  void _resetRoute() {
    polylinePoints.clear();
    fullRoutePoints.clear();
    routeBounds.value = null;
    distanceText.value = '0 km';
    isFormValid.value = false;
  }

  // --- GOOGLE DIRECTIONS API ---
  Future<void> fetchRealRoute() async {
    isLoadingRoute.value = true;
    final o = pickupLatLng.value!;
    final d = destinationLatLng.value!;

    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/directions/json'
          '?origin=${o.latitude},${o.longitude}'
          '&destination=${d.latitude},${d.longitude}'
          '&key=$googleApiKey'
          '&mode=driving',
    );

    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        if (data['status'] == 'OK') {
          final route = data['routes'][0];
          final leg = route['legs'][0];

          // Decode Polyline for map drawing
          final encoded = route['overview_polyline']['points'];
          fullRoutePoints.value = _decodePoly(encoded);
          polylinePoints.value = fullRoutePoints;

          // Calculate Map Bounds
          _calculateBounds(fullRoutePoints);

          // Meta Data
          distanceText.value = leg['distance']['text'];
          durationText.value = leg['duration']['text'];

          // Basic Price Estimation (Adjust as needed)
          final distanceKm = (leg['distance']['value'] as int) / 1000.0;
          estimatedPrice.value = (50 + (distanceKm * 20)).roundToDouble();

          isFormValid.value = true;
        }
      }
    } catch (e) {
      debugPrint("Route Fetch Error: $e");
    } finally {
      isLoadingRoute.value = false;
    }
  }

  Future<void> publishRide() async {
    try {
      isPublishing.value = true;

      // 1. Calculate raw distance and price per km
      double rawDist = double.tryParse(distanceText.value.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0.0;
      double pricePerKm = rawDist > 0 ? (estimatedPrice.value / rawDist) : 0.0;

      // 2. Prepare the Body Map
      final Map<String, dynamic> rideBody = {
        "pickUp": {
          "address": pickupAddress.value,
          "location": {
            "type": "Point",
            "coordinates": [pickupLatLng.value!.longitude, pickupLatLng.value!.latitude]
          }
        },
        "dropOff": {
          "address": destinationAddress.value,
          "location": {
            "type": "Point",
            "coordinates": [destinationLatLng.value!.longitude, destinationLatLng.value!.latitude]
          }
        },
        "goingDate": selectedDate.value.toIso8601String(),
        "stopOver": stopovers.map((s) => {
          "address": s.name,
          "location": {
            "type": "Point",
            "coordinates": [s.latLng.longitude, s.latLng.latitude]
          }
        }).toList(),
        "totalPassenger": availableSeats.value,
        "pricePerSeat": estimatedPrice.value.toInt(),
        "seatsBooked": 0,
        "distanceKm": rawDist.toInt(),
        "pricePerKm": pricePerKm.toInt()
      };

      String token = await PrefsHelper.getString(AppConstants.bearerToken);

      debugPrint("==========> [API REQUEST] <==========");
      debugPrint("URL: ${ApiConstants.createRide}");

      // 3. Hit the API
      // IMPORTANT: Use jsonEncode(rideBody) here to prevent the "Bad State" error
      var response = await ApiClient.postData(
        ApiConstants.createRide,
        jsonEncode(rideBody), // <--- CHANGE THIS
        headers: {
          'Content-Type': 'application/json', // Matches the encoded string
          'Authorization': 'Bearer $token',
        },
      );

      debugPrint("==========> [API RESPONSE] <==========");
      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Response Body: ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        CreateRideResponseModel result = CreateRideResponseModel.fromJson(response.body);

        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: CustomText(text: "Create Ride Successfully".tr,color: AppColors.backgroundColor,), backgroundColor: Colors.green),
          );
        }
        Get.offAllNamed(AppRoutes.driverHomeScreen);
      } else {
        _showErrorSnackBar(response.statusText ?? "Failed to create ride");
      }
    } catch (e) {
      debugPrint("===> Critical Error in publishRide: $e");
      _showErrorSnackBar("An unexpected error occurred");
    } finally {
      isPublishing.value = false;
    }
  }

// Helper to keep code clean
  void _showErrorSnackBar(String message) {
    if (Get.context != null) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  // --- HELPER METHODS ---
  void _calculateBounds(List<LatLng> points) {
    double minLat = points[0].latitude, maxLat = points[0].latitude;
    double minLng = points[0].longitude, maxLng = points[0].longitude;
    for (var p in points) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }
    routeBounds.value = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;
    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;
      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      points.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return points;
  }

  void goToRideDetails(){
    Get.to(AddCityScreen());
  }

  @override
  void onClose() {
    pickupController.dispose();
    destinationController.dispose();
    super.onClose();
  }
}