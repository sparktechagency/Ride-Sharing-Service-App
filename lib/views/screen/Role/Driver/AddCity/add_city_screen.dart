// lib/views/screen/Role/Driver/AddCity/add_city_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/screen/Role/stopover_picker/stopover_picker_screen.dart';

class Stopover {
  final String name;
  final LatLng latLng;
  Stopover({required this.name, required this.latLng});
}

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});
  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final controller = Get.put(PostRideController()); // ← FIXED
  final List<Stopover> stopovers = [];

  void _addStopover() async {
    final result = await Get.to(() => StopoverPickerScreen());
    if (result != null) {
      setState(() {
        stopovers.add(
          Stopover(name: result['address'], latLng: result['latLng']),
        );
      });
    }
  }

  void _removeStopover(int index) => setState(() => stopovers.removeAt(index));

  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = stopovers.removeAt(oldIndex);
      stopovers.insert(newIndex, item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: Text("Add Stopovers To Get More Passengers"),
      ),
      body: Column(
        children: [
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
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 24.h),
                  Expanded(
                    child:
                        stopovers.isEmpty
                            ? Center(
                              child: Text(
                                "No stopover added yet",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 16.sp,
                                ),
                              ),
                            )
                            : ReorderableListView(
                              onReorder: _reorder,
                              children:
                                  stopovers.asMap().entries.map((e) {
                                    int i = e.key;
                                    var city = e.value;
                                    return Container(
                                      key: ValueKey(city.name + i.toString()),
                                      margin: EdgeInsets.only(
                                        bottom: 12.h,
                                        left: 20.w,
                                        right: 20.w,
                                      ),
                                      padding: EdgeInsets.all(16.w),
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.drag_handle,
                                            color: Colors.grey,
                                          ),
                                          SizedBox(width: 12.w),
                                          Expanded(
                                            child: Text(
                                              city.name,
                                              style: TextStyle(fontSize: 16.sp),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () => _removeStopover(i),
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                            ),
                  ),
                  GestureDetector(
                    onTap: _addStopover,
                    child: Container(
                      width: double.infinity,
                      height: 64.h,
                      margin: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 30.h),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Center(
                        child: Text(
                          "Add Stopover on Route",
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
          Container(
            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: ElevatedButton(
              onPressed: () => Get.toNamed('/passengers-take'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.all(18.w),
              ),
              child: Text(
                "Next",
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
