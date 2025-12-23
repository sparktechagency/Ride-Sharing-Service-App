import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:ride_sharing/controllers/post_rider_controller.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_icons.dart';
import 'package:ride_sharing/utils/app_strings.dart';

class PickUpScreen extends StatefulWidget {
  const PickUpScreen({super.key});

  @override
  State<PickUpScreen> createState() => _PickUpScreenState();
}

class _PickUpScreenState extends State<PickUpScreen> {
  // Use existing controller (don't put new one!)
  final PostRideController controller = Get.put(PostRideController());

  GoogleMapController? mapController;
  LatLng? selectedLatLng;
  String selectedAddress = "";

  // Your real Google Places API Key (only the key, not full URL!)
  final String googleApiKey =
      "AIzaSyCrmEOP4JyFCozu7n85BIZqn_8LarJq_iI"; // Keep safe

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Get user's current location
  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar("Location Off", "Please enable location services");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar("Permission Denied", "Location access is required");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar("Blocked", "Go to settings and allow location access");
      return;
    }

    Get.dialog(
      Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      Get.back(); // close loading

      setState(() {
        selectedLatLng = LatLng(position.latitude, position.longitude);
        selectedAddress = "My Current Location";
      });

      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: selectedLatLng!, zoom: 17),
        ),
      );

      // Auto-confirm current location (most users expect this)
      controller.setLocation(
        type: Get.arguments['type'],
        address: selectedAddress,
        latLng: selectedLatLng!,
      );

      Get.back(); // Return to previous screen
    } catch (e) {
      Get.back();
      Get.snackbar("Error", "Failed to get current location");
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final String type =
        args?['type'] as String? ?? 'pickup'; // default fallback
    final String title =
        type == 'pickup' ? AppStrings.pICKUP.tr : AppStrings.dROPOFF.tr;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: AppColors.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target:
                  selectedLatLng ??
                  const LatLng(23.8103, 90.4125), // Dhaka default
              zoom: 14,
            ),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            onMapCreated: (GoogleMapController ctrl) {
              mapController = ctrl;
            },
          ),

          // Fixed Pin in Center
          Center(
            child: Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: Icon(Icons.location_on, size: 25.sp,color: AppColors.primaryColor,),
            ),
          ),

          // Search & Current Location Button
          Positioned(
            top: 100.h, // Below app bar
            left: 16.w,
            right: 16.w,
            child: Column(
              children: [
                // Search Field
                GooglePlaceAutoCompleteTextField(
                  textEditingController: _searchController,
                  googleAPIKey: googleApiKey,
                  inputDecoration: InputDecoration(
                    hintText: "Search for a place or address",
                    hintStyle: TextStyle(
                      color: AppColors.hintColor,
                      fontSize: 16.sp,
                    ),
                    filled: true,
                    fillColor:AppColors.whiteColor,
                    prefixIcon: Icon(
                      Icons.search,
                      size: 26,
                      color:AppColors.hintColor,
                    ),
                    suffixIcon:
                        _searchController.text.isNotEmpty
                            ? IconButton(
                              icon: Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                              },
                            )
                            : null,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  debounceTime: 600,
                  countries: ["bd"],
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (Prediction prediction) {
                    if (prediction.lat != null && prediction.lng != null) {
                      final lat = double.parse(prediction.lat!);
                      final lng = double.parse(prediction.lng!);

                      setState(() {
                        selectedLatLng = LatLng(lat, lng);
                        selectedAddress =
                            prediction.description ?? "Unknown Place";
                      });

                      mapController?.animateCamera(
                        CameraUpdate.newCameraPosition(
                          CameraPosition(target: selectedLatLng!, zoom: 16.5),
                        ),
                      );
                    }
                  },
                  itemClick: (Prediction prediction) {
                    _searchController.text = prediction.description ?? "";
                  },
                  itemBuilder: (context, index, Prediction prediction) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 14.h,
                        horizontal: 16.w,
                      ),
                      color: AppColors.whiteColor,
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: AppColors.greyColor,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              prediction.description ?? "",
                              style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  seperatedBuilder: Divider(height: 1),
                  isCrossBtnShown: true,
                ),

                SizedBox(height: 12.h),

                // Current Location Button
                Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                  elevation: 6,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16.r),
                    onTap: _getCurrentLocation,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 20.w,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.my_location,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 16.w),
                          Text(
                            "Use Current Location",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color:AppColors.greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Confirm Button
          Positioned(
            bottom: 30.h,
            left: 20.w,
            right: 20.w,
            child: SizedBox(
              height: 56.h,
              child: ElevatedButton(
                onPressed:
                    selectedLatLng == null
                        ? null
                        : () {
                          controller.setLocation(
                            type: type,
                            address:
                                selectedAddress.isEmpty
                                    ? "Selected Location on Map"
                                    : selectedAddress,
                            latLng: selectedLatLng!,
                          );
                          Get.back();
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: AppColors.bottomBarColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  elevation: 10,
                  shadowColor: Colors.indigo.withOpacity(0.4),
                ),
                child: Text(
                  "Confirm ${type == 'pickup' ? 'Pickup' : 'Drop-off'}",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:ride_sharing/views/base/custom_app_bar.dart';

// import '../../../../../utils/app_icons.dart';
// import '../../../../../utils/app_strings.dart';
// import '../../../../base/custom_list_tile.dart';
// import '../../../../base/custom_text.dart';
// import '../../../../base/custom_text_field.dart';

// class PickUpScreen extends StatelessWidget {
//   PickUpScreen({super.key});
//   final TextEditingController _controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: AppStrings.pICKUP.tr),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 20.sp),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CustomText(
//                 text: AppStrings.pICKUP.tr,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 18.sp,
//                 bottom: 16.sp,
//               ),
//               //=========================> Search Bar <=========================
//               CustomTextField(
//                 controller: _controller,
//                 hintText: AppStrings.enterTheFullAddress.tr,
//                 prefixIcon: SvgPicture.asset(AppIcons.search),
//               ),
//               SizedBox(height: 24.h),
//               //=========================> Use Current Location <=========================
//               CustomListTile(
//                 title: AppStrings.useCurrentLocation.tr,
//                 prefixIcon: SvgPicture.asset(AppIcons.current),
//                 suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
