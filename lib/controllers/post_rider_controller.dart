import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:ride_sharing/views/screen/Role/Driver/rider_post_submit/rider_post_submit.dart';

class Stopover {
  final String name;
  final LatLng latLng;
  Stopover({required this.name, required this.latLng});
}

class PostRideController extends GetxController {
  // Text Controllers
  final pickupController = TextEditingController();
  final destinationController = TextEditingController();

  // Location Data
  var pickupLatLng = Rxn<LatLng>();
  var destinationLatLng = Rxn<LatLng>();
  var pickupAddress = ''.obs;
  var destinationAddress = ''.obs;

  // Route Data
  var polylinePoints = <LatLng>[].obs;
  var fullRoutePoints = <LatLng>[].obs; // ← Full real driving path
  var routeBounds = Rxn<LatLngBounds>(); // ← For map zoom

  var distanceText = ''.obs;
  var durationText = ''.obs;
  var mainRoadName = 'Unknown Road'.obs;
  var hasTolls = false.obs;
  var isLoadingRoute = false.obs;
  var isFormValid = false.obs;

  // Stopovers (added from AddCityScreen)
  var stopovers = <Stopover>[].obs;

  // Pricing
  var estimatedPrice = 0.0.obs;

  // Google API Key
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

  void addStopover(String name, LatLng latLng) {
    stopovers.add(Stopover(name: name, latLng: latLng));
  }

  void removeStopover(int index) {
    stopovers.removeAt(index);
  }

  void clearStopovers() {
    stopovers.clear();
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
          final leg = route['legs'][0];

          // SAVE FULL ROUTE
          final encoded = route['overview_polyline']['points'];
          fullRoutePoints.value = _decodePoly(encoded);
          polylinePoints.value = fullRoutePoints;

          // Calculate bounds
          double minLat = fullRoutePoints[0].latitude,
              maxLat = fullRoutePoints[0].latitude;
          double minLng = fullRoutePoints[0].longitude,
              maxLng = fullRoutePoints[0].longitude;
          for (var p in fullRoutePoints) {
            if (p.latitude < minLat) minLat = p.latitude;
            if (p.latitude > maxLat) maxLat = p.latitude;
            if (p.longitude < minLng) minLng = p.longitude;
            if (p.longitude > maxLng) maxLng = p.longitude;
          }
          routeBounds.value = LatLngBounds(
            southwest: LatLng(minLat, minLng),
            northeast: LatLng(maxLat, maxLng),
          );

          // Distance & Time
          distanceText.value = leg['distance']['text'];
          durationText.value = leg['duration']['text'];

          // Tolls & Road Name
          hasTolls.value =
              (route['warnings'] as List?)?.any(
                (w) => w.toString().toLowerCase().contains('toll'),
              ) ==
              true;

          String road = "Main Road";
          for (var step in leg['steps']) {
            final instr =
                step['html_instructions']?.toString().toLowerCase() ?? "";
            if (instr.contains('mirpur'))
              road = "Mirpur Rd";
            else if (instr.contains('uttara'))
              road = "Airport Rd";
            else if (instr.contains('gulshan'))
              road = "Gulshan Ave";
            if (road != "Main Road") break;
          }
          mainRoadName.value = road;

          // Price
          final distanceKm = (leg['distance']['value'] as int) / 1000.0;
          double price = 50 + (distanceKm * 20);
          estimatedPrice.value = price.roundToDouble();

          isFormValid.value = true;
        }
      }
    } catch (e) {
      final dist = Geolocator.distanceBetween(
        o.latitude,
        o.longitude,
        d.latitude,
        d.longitude,
      );
      distanceText.value = "≈ ${(dist / 1000).toStringAsFixed(1)} km";
      fullRoutePoints.value = [o, d];
      polylinePoints.value = [o, d];
    } finally {
      isLoadingRoute.value = false;
    }
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

  // FINAL: Publish the ride
  void publishRide() {
    final rideData = {
      'pickup_address': pickupAddress.value,
      'destination_address': destinationAddress.value,
      'pickup_lat': pickupLatLng.value!.latitude,
      'pickup_lng': pickupLatLng.value!.longitude,
      'destination_lat': destinationLatLng.value!.latitude,
      'destination_lng': destinationLatLng.value!.longitude,
      'distance': distanceText.value,
      'duration': durationText.value,
      'estimated_price': estimatedPrice.value,
      'main_road': mainRoadName.value,
      'has_tolls': hasTolls.value,
      'stopovers':
          stopovers
              .map(
                (s) => {
                  'name': s.name,
                  'lat': s.latLng.latitude,
                  'lng': s.latLng.longitude,
                },
              )
              .toList(),
      'published_at': DateTime.now().toIso8601String(),
    };

    // TODO: Send to backend
    print("RIDE PUBLISHED: $rideData");

    // Show success screen
    Get.offAll(() => const RiderPostSubmit());
  }

  void goToRideDetails() {
    Get.toNamed('/add-city');
  }

  @override
  void onClose() {
    pickupController.dispose();
    destinationController.dispose();
    super.onClose();
  }
}
