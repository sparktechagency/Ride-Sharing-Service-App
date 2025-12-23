import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../controllers/single_ride_details_controller.dart';
import '../../../../../../models/single_ride_details_model.dart';

class SingleRideDetailsScreen extends StatelessWidget {
  final String rideId;
  final SingleRideDetailsController controller = Get.put(SingleRideDetailsController());

  SingleRideDetailsScreen({super.key, required this.rideId}) {
    controller.fetchRideDetails(rideId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text("Details", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.rideDetails.value;
        if (data == null) {
          return const Center(child: Text("No Details Found"));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTripCard(data),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total User (${data.bookingUsers.length.toString().padLeft(2, '0')})",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(onPressed: () {}, child: const Text("See all", style: TextStyle(color: Colors.grey))),
                ],
              ),
              const SizedBox(height: 10),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: data.bookingUsers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildUserTile(data.bookingUsers[index]);
                },
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.chat_bubble_outline),
      ),
    );
  }

  Widget _buildTripCard(SingleRideDetailsModel data) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, spreadRadius: 2)],
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today  ${DateFormat('hh.mm a').format(data.createdAt)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(color: Colors.cyan, borderRadius: BorderRadius.circular(20)),
                  child: Text(data.status, style: const TextStyle(color: Colors.white, fontSize: 12)),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          // Route Info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Column(
                  children: [
                    const Icon(Icons.radio_button_off, color: Colors.grey, size: 20),
                    Container(width: 2, height: 40, color: Colors.grey.shade300),
                    const Icon(Icons.radio_button_off, color: Colors.grey, size: 20),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _locationRow(DateFormat('hh.mma').format(data.createdAt), data.pickUp.address),
                      const SizedBox(height: 25),
                      _locationRow("11.30PM", data.dropOff.address), // Static time as example
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(height: 1),
          // Stats
          _infoRow("Total Passengers Seat :", "${data.totalPassenger} Person"),
          _infoRow("Booking Seat :", "${data.seatsBooked.toString().padLeft(2, '0')} Person"),
          const Divider(height: 1),
          _infoRow("Available Seat :", "${data.totalPassenger - data.seatsBooked} Seat"),
          _infoRow("Per Seat Price :", "\$ ${data.pricePerSeat}", isPrice: true),
          // Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Start Trip", style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _locationRow(String time, String address) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(time, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(address, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _infoRow(String label, String value, {bool isPrice = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 15)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isPrice ? 20 : 15,
              color: isPrice ? Colors.cyan : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(BookingUser user) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          Container(
            width: 50, height: 50,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text("Location: ", style: TextStyle(fontSize: 12, color: Colors.grey)),
                    const Text("Dhaka", style: TextStyle(fontSize: 12)),
                    const Icon(Icons.arrow_right_alt, size: 16, color: Colors.grey),
                    const Text("Mirpur 10", style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
          const Text("4.8", style: TextStyle(fontWeight: FontWeight.bold)),
          const Icon(Icons.star, color: Colors.amber, size: 20),
        ],
      ),
    );
  }
}