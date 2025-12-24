
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/screen/Role/stopover_picker/stopover_picker_screen.dart';

import '../PickUp/ride_summary_screen.dart';

class AddCityScreen extends StatefulWidget {
  const AddCityScreen({super.key});
  @override
  State<AddCityScreen> createState() => _AddCityScreenState();
}

class _AddCityScreenState extends State<AddCityScreen> {
  final controller = Get.find<PostRideController>();

  // Use localStopovers to avoid naming conflicts with the controller
  final List<Stopover> localStopovers = [];

  void _addStopover() async {
    final result = await Get.to(() => const StopoverPickerScreen());
    if (result != null) {
      setState(() {
        localStopovers.add(
          Stopover(name: result['address'], latLng: result['latLng']),
        );
      });
    }
  }

  // Updated to use localStopovers
  void _removeStopover(int index) => setState(() => localStopovers.removeAt(index));

  // Updated to use localStopovers
  void _reorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) newIndex -= 1;
      final item = localStopovers.removeAt(oldIndex);
      localStopovers.insert(newIndex, item);
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
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Get.back(),
        ),
        title: const Text("Add Stopovers"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: const [
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
                    child: localStopovers.isEmpty
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
                      children: localStopovers.asMap().entries.map((e) {
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
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.drag_handle, color: Colors.grey),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  city.name,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              GestureDetector(
                                onTap: () => _removeStopover(i),
                                child: const Icon(Icons.close, color: Colors.red),
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

          // Final Confirmation Button
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
            child: ElevatedButton(
              onPressed: () {
                // 1. Move the local list into the Controller's RxList
                controller.stopovers.clear();

                // 2. This will now work perfectly because the 'Stopover' types match
                controller.stopovers.assignAll(localStopovers);

                // 3. Move to mapping screen
                Get.to(() => const RideSummaryScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.all(18.w),
              ),
              child: Text(
                "Confirm Route Details",
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
