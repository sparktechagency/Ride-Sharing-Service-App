// lib/views/screens/post_rides_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_text_field.dart';
import 'package:ride_sharing/views/screen/Role/Driver/BottomNavBar/driver_bottom_menu..dart';

class PostRidesScreen extends StatelessWidget {
  const PostRidesScreen({super.key});
  void _showRouteSheet() {
    Get.bottomSheet(
      const _RouteSelectionBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
    );
  }
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostRideController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        title: Text(
          AppStrings.createRide.tr,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      bottomNavigationBar: const DriverBottomMenu(1),
      body: Obx(() {
        final p = controller.pickupLatLng.value;
        final d = controller.destinationLatLng.value;
        final points = controller.polylinePoints;
        final markers = <Marker>{};
        if (p != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('pickup'),
              position: p,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen,
              ),
            ),
          );
        }
        if (d != null) {
          markers.add(
            Marker(
              markerId: const MarkerId('destination'),
              position: d,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueRed,
              ),
            ),
          );
        }
        final polylines =
            points.isNotEmpty
                ? {
                  Polyline(
                    polylineId: const PolylineId('route'),
                    color: Colors.indigo.shade700,
                    width: 7,
                    points: points,
                  ),
                }
                : <Polyline>{};

        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: p ?? d ?? const LatLng(23.8103, 90.4125),
                zoom: 12,
              ),
              markers: markers,
              polylines: polylines,
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: (c) {
                if (p != null && d != null && points.isNotEmpty) {
                  final bounds = LatLngBounds(
                    southwest: LatLng(
                      p.latitude < d.latitude ? p.latitude : d.latitude,
                      p.longitude < d.longitude ? p.longitude : d.longitude,
                    ),
                    northeast: LatLng(
                      p.latitude > d.latitude ? p.latitude : d.latitude,
                      p.longitude > d.longitude ? p.longitude : d.longitude,
                    ),
                  );
                  c.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
                }
              },
            ),
            if (controller.isLoadingRoute.value)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
              ),

            SafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                child: Column(
                  children: [
                    _field(
                      controller.pickupController,
                      AppStrings.pICKUP.tr,
                      Icons.location_on,
                      Colors.green.shade700,
                      () => Get.toNamed(
                        AppRoutes.pickUpScreen,
                        arguments: {'type': 'pickup'},
                      ),
                    ),
                    _field(
                      controller.destinationController,
                      AppStrings.dROPOFF.tr,
                      Icons.flag,
                      Colors.red.shade700,
                      () => Get.toNamed(
                        AppRoutes.pickUpScreen,
                        arguments: {'type': 'destination'},
                      ),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed:
                            controller.isFormValid.value
                                ? _showRouteSheet
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        child: Text(
                          AppStrings.next.tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _field(ctrl, hint, icon, color, onTap) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: CustomTextField(
        controller: ctrl,
        readOnly: true,
        hintText: hint,
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(icon, color: color, size: 24.w),
        ),
        onTab: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 16.w),
      ),
    );
  }
}

// BOTTOM SHEET
class _RouteSelectionBottomSheet extends StatefulWidget {
  const _RouteSelectionBottomSheet();
  @override
  State<_RouteSelectionBottomSheet> createState() =>
      _RouteSelectionBottomSheetState();
}
class _RouteSelectionBottomSheetState
    extends State<_RouteSelectionBottomSheet> {
  int selected = 0;
  final c = Get.find<PostRideController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 40.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 5.h,
            color: Colors.grey.shade300,

            // borderRadius: BorderRadius.circular(10),
          ),
          SizedBox(height: 24.h),
          Text(
            "What Is Your Route?",
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 24.h),
          // Real Route (from Google)
          _routeCard(
            distance: c.distanceText.value,
            road: c.mainRoadName.value,
            time: c.durationText.value,
            tolls: c.hasTolls.value,
            selected: selected == 0,
            onTap: () => setState(() => selected = 0),
          ),
          SizedBox(height: 16.h),
          // Alternative Route (fake for now)
          _routeCard(
            distance:
                "${(double.tryParse(c.distanceText.value.split(' ')[0]) ?? 4.0 + 1.2).toStringAsFixed(1)} km",
            road: "Alternative Route",
            time:
                "${(int.tryParse(c.durationText.value.split(' ')[0]) ?? 12) + 5} mins",
            tolls: true,
            selected: selected == 1,
            onTap: () => setState(() => selected = 1),
          ),
          SizedBox(height: 32.h),
          SizedBox(
            width: double.infinity,
            height: 58.h,
            child: ElevatedButton(
              onPressed: () {
                Get.back();
                c.goToRideDetails();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                "Submit",
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _routeCard({
    required String distance,
    required String road,
    required String time,
    required bool tolls,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20.w),
        margin: EdgeInsets.symmetric(vertical: 6.h),
        decoration: BoxDecoration(
          color: selected ? Colors.blue.shade50 : Colors.grey.shade50,
          border: Border.all(
            color: selected ? Colors.blue.shade500 : Colors.grey.shade300,
            width: selected ? 2.5 : 1.5,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 28.w,
              height: 28.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.blue.shade500, width: 2.5),
                color: selected ? Colors.blue.shade500 : Colors.white,
              ),
              child:
                  selected
                      ? Icon(Icons.circle, size: 16.w, color: Colors.white)
                      : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$distance - $road",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "$time - ${tolls ? "Has Tolls" : "No Tolls"}",
                    style: TextStyle(
                      fontSize: 15.sp,
                      color:
                          tolls ? Colors.red.shade600 : Colors.green.shade600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
