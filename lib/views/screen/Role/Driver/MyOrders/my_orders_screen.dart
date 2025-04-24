import 'package:flutter/material.dart';

import '../../../../base/custom_text.dart';
import '../BottomNavBar/bottom_menu..dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(3),
      body: Center(child: CustomText(text: 'This is My Order Screen')),
    );
  }
}
