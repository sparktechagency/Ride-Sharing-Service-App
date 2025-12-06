// lib/controllers/post_ride_controller.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ride_sharing/views/screen/Role/Driver/AddCity/add_city_screen.dart';
import 'package:geolocator/geolocator.dart';

class PostRideController extends GetxController {
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  var pickupLatLng = Rxn<LatLng>();
  var destinationLatLng = Rxn<LatLng>();
  var pickupAddress = ''.obs;
  var destinationAddress = ''.obs;

  var polylinePoints = <LatLng>[].obs;
  var distanceText = ''.obs; // e.g., "4.2 km"
  var durationText = ''.obs; // e.g., "12 mins"
  var mainRoadName = 'Unknown Road'.obs;
  var hasTolls = false.obs;
  var isLoadingRoute = false.obs;
  var isFormValid = false.obs;

  // Pricing
  var estimatedPrice = 0.0.obs;

  final String googleApiKey = "AIzaSyBv_OSFFFy0xPIimcp2XO2lWmYSInjqk_E";

  @override
  void onInit() {
    super.onInit();
    ever(pickupLatLng, (_) => _tryFetchRoute());
    ever(destinationLatLng, (_) => _tryFetchRoute());
  }

  void setLocation({
    required String type,
    required String address,
    required LatLng latLng,
  }) {
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
    distanceText.value = '';
    durationText.value = '';
    mainRoadName.value = 'Unknown Road';
    hasTolls.value = false;
    isFormValid.value = false;
  }

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
          final routeLeg = route['legs'][0];

          // Polyline
          polylinePoints.value = _decodePoly(
            route['overview_polyline']['points'],
          );

          // Distance & Time
          distanceText.value = routeLeg['distance']['text'];
          durationText.value = routeLeg['duration']['text'];

          // Extract distance in km
          final distanceKm = (routeLeg['distance']['value'] as int) / 1000.0;

          // Detect tolls
          hasTolls.value =
              (route['warnings'] as List?)?.any(
                (w) => w.toString().toLowerCase().contains('toll'),
              ) ==
              true;

          // Extract main road name from instructions
          String road = "Main Road";
          for (var step in routeLeg['steps']) {
            final instr =
                step['html_instructions']?.toString().toLowerCase() ?? "";
            if (instr.contains('mirpur')) {
              road = "Mirpur Rd";
            } else if (instr.contains('uttara'))
              road = "Airport Rd";
            else if (instr.contains('gulshan'))
              road = "Gulshan Ave";
            else if (instr.contains('dhanmondi'))
              road = "Dhanmondi Rd";
            else if (instr.contains('banani'))
              road = "Banani Rd";
            if (road != "Main Road") break;
          }
          mainRoadName.value = road;

          // Price calculation
          double price = 50 + (distanceKm * 20);
          estimatedPrice.value = price.roundToDouble();

          isFormValid.value = true;
        }
      }
    } catch (e) {
      // Fallback
      distanceText.value =
          "≈ ${((Geolocator.distanceBetween(o.latitude, o.longitude, d.latitude, d.longitude)) / 1000).toStringAsFixed(1)} km";
      durationText.value =
          "~ ${((Geolocator.distanceBetween(o.latitude, o.longitude, d.latitude, d.longitude)) / 100).toStringAsFixed(0)} mins";
      mainRoadName.value = "Direct Route";
      hasTolls.value = false;
    } finally {
      isLoadingRoute.value = false;
    }
  }

  List<LatLng> _decodePoly(String encoded) {
    // Your existing decode function (keep it)
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

  void goToRideDetails() {
    Get.to(() => AddCityScreen());
  }

  @override
  void onClose() {
    pickupController.dispose();
    destinationController.dispose();
    super.onClose();
  }
}
