// lib/views/screens/stopover_picker_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

import 'package:ride_sharing/controllers/post_rider_controller.dart';

class StopoverPickerScreen extends StatefulWidget {
  const StopoverPickerScreen({super.key});
  @override State<StopoverPickerScreen> createState() => _StopoverPickerScreenState();
}

class _StopoverPickerScreenState extends State<StopoverPickerScreen> {
  final controller = Get.put(PostRideController()); // ← FIXED
  GoogleMapController? mapController;
  LatLng? selectedPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pick Stopover on Route"),
        backgroundColor: Color(0xFF0066FF),
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        final points = controller.fullRoutePoints;
        final bounds = controller.routeBounds.value;

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: points.isNotEmpty ? points[points.length ~/ 2] : LatLng(23.81, 90.41),
                zoom: 11,
              ),
              polylines: {
                Polyline(polylineId: PolylineId('route'), color: Colors.blue.shade700, width: 8, points: points),
              },
              myLocationEnabled: true,
              onMapCreated: (c) {
                mapController = c;
                if (bounds != null) c.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
              },
              onTap: (latLng) {
                if (_isNearRoute(latLng, points)) {
                  setState(() => selectedPoint = latLng);
                } else {
                  Get.snackbar("Invalid", "Please tap on the blue route only", backgroundColor: Colors.red, colorText: Colors.white);
                }
              },
              markers: selectedPoint != null
                  ? {Marker(markerId: MarkerId('stop'), position: selectedPoint!, icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange))}
                  : {},
            ),
            if (selectedPoint != null)
              Positioned(
                bottom: 30.h,
                left: 20.w,
                right: 20.w,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.check_circle),
                  label: Text("Confirm Stopover"),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: EdgeInsets.all(16.w), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r))),
                  onPressed: () async {
                    final address = await _getAddress(selectedPoint!);
                    Get.back(result: {'address': address, 'latLng': selectedPoint});
                  },
                ),
              ),
          ],
        );
      }),
    );
  }

  bool _isNearRoute(LatLng point, List<LatLng> route) {
    for (var p in route) {
      if (_haversine(point, p) < 100) return true; // 100 meters
    }
    return false;
  }

  double _haversine(LatLng a, LatLng b) {
    const R = 6371000;
    final dLat = (b.latitude - a.latitude) * pi / 180;
    final dLng = (b.longitude - a.longitude) * pi / 180;
    final x = sin(dLat / 2) * sin(dLat / 2) +
        cos(a.latitude * pi / 180) * cos(b.latitude * pi / 180) * sin(dLng / 2) * sin(dLng / 2);
    final c = 2 * atan2(sqrt(x), sqrt(1 - x));
    return R * c;
  }

  Future<String> _getAddress(LatLng latLng) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=${controller.googleApiKey}');
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        final data = json.decode(res.body);
        return data['results'][0]['formatted_address'];
      }
    } catch (e) {}
    return "Stopover Point";
  }
}