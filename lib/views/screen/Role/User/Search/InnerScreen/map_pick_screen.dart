import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';

import '../../../../../../controllers/search_ride_controller.dart';
import '../../../../../../utils/app_colors.dart';


class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  late GoogleMapController mapController;
  LatLng? selectedLatLng;

  final SearchRideController controller = Get.find();
  final TextEditingController searchCTRL = TextEditingController();
  final RxString query = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.currentSearchType.value == 'pickup'
              ? "Select Pickup Location"
              : "Select Drop-off Location",
        )),
      ),
      body: Column(
        children: [
          // ================= SEARCH BAR =================
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: searchCTRL,
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Search location...".tr,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: Obx(() => query.value.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchCTRL.clear();
                    query.value = '';
                    controller.clearSearchResults();
                  },
                )
                    : const SizedBox.shrink()),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (val) async {
                query.value = val;
                debugPrint("🔍 Search query: $val");
                await controller.searchPlaces(val);
                debugPrint("🔍 Search results: ${controller.searchResults.length}");
              },
            ),
          ),

          // ================= MAP =================
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: selectedLatLng ?? const LatLng(23.8103, 90.4125),
                    zoom: 12,
                  ),
                  onMapCreated: (controller) {
                    mapController = controller;
                  },
                  onTap: (latLng) async {
                    selectedLatLng = latLng;
                    final address = await this.controller.getAddressFromLatLng(latLng);
                    setState(() {});
                    Get.back(result: SelectionResult(latLng, address));
                  },
                  markers: selectedLatLng != null
                      ? {Marker(markerId: const MarkerId('selected'), position: selectedLatLng!)}
                      : {},
                ),

                // ================= SEARCH RESULTS =================
                Obx(() {
                  if (controller.searchResults.isEmpty || query.value.isEmpty) return const SizedBox.shrink();

                  return Positioned(
                    top: 70,
                    left: 12,
                    right: 12,
                    child: Material(
                      elevation: 5,
                      borderRadius: BorderRadius.circular(12),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.searchResults.length,
                        itemBuilder: (context, index) {
                          final place = controller.searchResults[index];
                          return ListTile(
                            title: Text(place['description']),
                            onTap: () async {
                              Get.dialog(
                                const Center(child: CircularProgressIndicator()),
                                barrierDismissible: false,
                              );

                              final latLng = await controller.getLatLngFromAddress(place['description']);
                              Get.back();

                              if (latLng != null) {
                                Get.back(result: SelectionResult(latLng, place['description']));
                              }
                            },
                          );
                        },
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SelectionResult {
  final LatLng latLng;
  final String address;

  SelectionResult(this.latLng, this.address);
}

