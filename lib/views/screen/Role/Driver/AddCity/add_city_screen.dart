// lib/views/screen/Role/Driver/AddCity/add_city_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_icons.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../../../base/custom_app_bar.dart';

class Stopover {
  final String name;
  final LatLng latLng;
  Stopover({required this.name, required this.latLng});
}

class AddCityScreen extends StatefulWidget {
  final String? date;
  final String? time;
  const AddCityScreen({super.key, this.date, this.time});

  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  // Use existing controller — NEVER Get.put() again!
  final controller = Get.put(PostRideController());

  // Local list for stopovers
  final List<Stopover> stopovers = <Stopover>[];

  // Reactive date & time
  late RxString selectedDate;
  late RxString selectedTime;

  @override
  void initState() {
    super.initState();
    selectedDate = (widget.date ?? "Wed, Feb 12").obs;
    selectedTime = (widget.time ?? "5:23 PM").obs;
  }

  void _addStopover(String name, LatLng latLng) {
    setState(() {
      stopovers.add(Stopover(name: name, latLng: latLng));
    });
  }

  void _removeStopover(int index) {
    setState(() {
      stopovers.removeAt(index);
    });
  }

  void _openMapPicker() async {
    final result = await Get.toNamed(
      AppRoutes.pickUpScreen,
      arguments: {'type': 'stopover'},
    );

    if (result != null && result is Map<String, dynamic>) {
      final String address = result['address'] ?? "Unknown Location";
      final LatLng latLng = result['latLng'];
      _addStopover(address, latLng);
    }
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0066FF)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final months = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      selectedDate.value =
          "${_getWeekday(picked.weekday)}, ${months[picked.month - 1]} ${picked.day}";
    }
  }

  String _getWeekday(int weekday) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[weekday - 1];
  }

  Future<void> _pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF0066FF)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final hour =
          picked.hour == 0
              ? 12
              : picked.hour > 12
              ? picked.hour - 12
              : picked.hour;
      final minute = picked.minute.toString().padLeft(2, '0');
      final period = picked.hour >= 12 ? "PM" : "AM";
      selectedTime.value = "$hour:$minute $period";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black87),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Add Stopovers To Get More Passengers",
          style: TextStyle(color: Colors.black87, fontSize: 16.sp),
        ),
      ),
      body: Column(
        children: [
          // Main Card
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Stopover List
                  Expanded(
                    child:
                        stopovers.isEmpty
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_location_alt_outlined,
                                    size: 60.w,
                                    color: Colors.grey.shade400,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    "No stopover added yet",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: stopovers.length,
                              itemBuilder: (context, i) {
                                final city = stopovers[i];
                                return Container(
                                  margin: EdgeInsets.only(bottom: 12.h),
                                  padding: EdgeInsets.all(16.w),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    borderRadius: BorderRadius.circular(16.r),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          city.name,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => _removeStopover(i),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.red.shade400,
                                          size: 22.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                  ),

                  // Add City Button
                  GestureDetector(
                    onTap: _openMapPicker,
                    child: Container(
                      width: double.infinity,
                      height: 64.h,
                      margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0066FF),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Add City",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Next Button
          Container(
            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: SizedBox(
              height: 58.h,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showPreviewDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0066FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  elevation: 8,
                ),
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPreviewDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28.r),
            ),
            child: Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => Get.back(),
                      child: SvgPicture.asset(AppIcons.cancel),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  CustomText(
                    text: "When Are You Going?",
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),

                  SizedBox(height: 30.h),

                  // From → To
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Color(0xFF0066FF),
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                controller.pickupAddress.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Icon(Icons.arrow_forward),
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(16.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("To"),
                              Text(
                                controller.destinationAddress.value,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Stopovers
                  if (stopovers.isNotEmpty) ...[
                    SizedBox(height: 20.h),
                    ...stopovers.map(
                      (city) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h),
                        child: Container(
                          padding: EdgeInsets.all(14.w),
                          decoration: BoxDecoration(
                            color: Color(0xFF0066FF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.stop_circle, color: Color(0xFF0066FF)),
                              SizedBox(width: 12.w),
                              Text(city.name),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                  SizedBox(height: 30.h),

                  // Date & Time (clickable)
                  GestureDetector(
                    onTap: () => _pickDate(context),
                    child: Obx(
                      () => Text(
                        selectedDate.value,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  GestureDetector(
                    onTap: () => _pickTime(context),
                    child: Obx(
                      () => Text(
                        selectedTime.value,
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0066FF),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  CustomButton(
                    onTap: () {
                      Get.back();
                      Get.toNamed(AppRoutes.cityViewScreen);
                    },
                    text: "Next",
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
