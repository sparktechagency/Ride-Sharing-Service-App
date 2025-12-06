import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackground extends StatelessWidget {
  final Widget child;
  const CustomBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xff00AFF5), Color(0xffB4E8FD)],
          stops: const [0.2266, 0.9998],
        ),
      ),
      child: child,
    );
  }
}
