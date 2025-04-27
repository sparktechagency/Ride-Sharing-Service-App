import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';

import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_list_tile.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class PickUpScreen extends StatelessWidget {
  PickUpScreen({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.pICKUP.tr),
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
                controller: _controller,
                hintText: AppStrings.enterTheFullAddress.tr,
                prefixIcon: SvgPicture.asset(AppIcons.search),
              ),
              SizedBox(height: 24.h),
              //=========================> Use Current Location <=========================
              CustomListTile(
                title: AppStrings.useCurrentLocation.tr,
                prefixIcon: SvgPicture.asset(AppIcons.current),
                suffixIcon: SvgPicture.asset(AppIcons.rightArrow),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
