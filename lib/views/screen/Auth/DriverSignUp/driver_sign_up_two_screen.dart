import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class DriverSignUpTwoScreen extends StatelessWidget {
  DriverSignUpTwoScreen({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //========================> Address Text Field <==================
              CustomText(
                text: AppStrings.address.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              CustomTextField(
                controller: _authController.addressCtrl,
                hintText: AppStrings.enterYourAddress.tr,
                prefixIcon: SvgPicture.asset(AppIcons.location),
              ),
              //========================> Date Of Birth Day Text Field <==================
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.dateOfBirth.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              CustomTextField(
                onTab: () {
                  _authController.pickBirthDate(context);
                },
                readOnly: true,
                controller: _authController.dateOfBirthCtrl,
                hintText: AppStrings.dateOfBirth.tr,
                prefixIcon: SvgPicture.asset(AppIcons.calender),
              ),
              //========================> Vehicles type Text Field <==================
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.vehiclesType.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              CustomTextField(
                controller: _authController.vehiclesTypeCtrl,
                hintText: AppStrings.vehiclesType.tr,
                prefixIcon: SvgPicture.asset(AppIcons.type),
              ),
              //========================> Vehicles model Text Field <==================
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.vehiclesModel.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              CustomTextField(
                controller: _authController.vehiclesModelCtrl,
                hintText: AppStrings.vehiclesModel.tr,
                prefixIcon: SvgPicture.asset(AppIcons.model),
              ),
              //========================> License plate Text Field <==================
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.licensePlate.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              CustomTextField(
                keyboardType: TextInputType.number,
                controller: _authController.licenseNumberCtrl,
                hintText: AppStrings.typeNumber.tr,
                prefixIcon: SvgPicture.asset(AppIcons.licenseNum),
              ),
              //========================> Back And Next Button <==================
              SizedBox(height: 98.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onTap: () {Get.back();},
                    text: AppStrings.back.tr,
                    height: 48.h,
                    width: 158.w,
                    color: Colors.white,
                    textColor: AppColors.primaryColor,
                  ),
                  CustomButton(
                    onTap: () {Get.toNamed(AppRoutes.driverSignUpThreeScreen);},
                    text: AppStrings.next.tr,
                    height: 48.h,
                    width: 158.w,
                  ),
                ],
              ),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
