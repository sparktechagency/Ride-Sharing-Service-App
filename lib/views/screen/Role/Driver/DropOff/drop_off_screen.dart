import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/app_icons.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_app_bar.dart';
import '../../../../base/custom_list_tile.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';

class DropOffScreen extends StatelessWidget {
  DropOffScreen({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.dROPOFF.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CustomText(
                text: AppStrings.dROPOFF.tr,
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
