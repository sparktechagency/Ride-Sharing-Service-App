import 'package:flutter/material.dart';

import '../Role/Driver/BottomNavBar/bottom_menu..dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: BottomMenu(1),
    );
  }
}
