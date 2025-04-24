import 'package:flutter/material.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../BottomNavBar/bottom_menu..dart';

class DriverHomeScreen extends StatelessWidget {
  const DriverHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(0),
      body: Center(child: CustomText(text: 'This is Home Screen')),
    );
  }
}
