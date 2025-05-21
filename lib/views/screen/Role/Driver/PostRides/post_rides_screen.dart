import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_icons.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_list_tile.dart';
import 'package:ride_sharing/views/base/custom_text_field.dart';

import '../../../../base/custom_text.dart';
import '../BottomNavBar/driver_bottom_menu..dart';

class PostRidesScreen extends StatelessWidget {
  PostRidesScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DriverBottomMenu(1),
      appBar: AppBar(
        leading: SizedBox(),
        title: CustomText(
          text: AppStrings.createRide.tr,
          fontWeight: FontWeight.w500,
          fontSize: 16.sp,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: AppStrings.pICKUP.tr,
                fontWeight: FontWeight.w500,
                fontSize: 18.sp,
                bottom: 16.sp,
              ),
              //=========================> Search Bar <=========================
              CustomTextField(
                onTab: () {
                  Get.toNamed(AppRoutes.pickUpScreen);
                },
                readOnly: true,
                controller: _controller,
                hintText: AppStrings.enterTheFullAddress.tr,
                prefixIcon: SvgPicture.asset(AppIcons.search),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
