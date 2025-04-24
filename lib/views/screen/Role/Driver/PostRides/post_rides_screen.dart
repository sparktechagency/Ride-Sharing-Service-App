import 'package:flutter/material.dart';

import '../../../../base/custom_text.dart';
import '../BottomNavBar/bottom_menu..dart';

class PostRidesScreen extends StatelessWidget {
  const PostRidesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomMenu(1),
      body: Center(child: CustomText(text: 'This is Post Ride Screen')),
    );
  }
}
