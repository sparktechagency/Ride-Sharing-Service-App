import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 164.h),
              Center(child: Image.asset(AppImages.appLogo, width: 91.w, height: 94.h)),
              SizedBox(height: 24.h),
              //========================> Forgot Password Title <==================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        text: AppStrings.forgot.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(
                        width: 70.w,
                        height: 8.h,
                        child: Divider(
                          thickness: 5.5,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  CustomText(
                    text: 'Password'.tr,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    bottom: 6.h,
                  ),
                ],
              ),
              //========================> Forgot Password Sub Title <==================
              SizedBox(height: 14.h),
              Center(child: CustomText(text: AppStrings.pleaseEnterYourPhoneNumber.tr, maxLine: 3)),
              //=============================> Phone number Text Field <====================
              SizedBox(height: 16.h),
              CustomText(
                text: AppStrings.phoneNumber.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                bottom: 14.h,
              ),
              IntlPhoneField(
                decoration: InputDecoration(
                  hintText: "Phone number".tr,
                  contentPadding:EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide: BorderSide(color: AppColors.borderColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide: BorderSide(color: AppColors.borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.r)),
                    borderSide: BorderSide(color: AppColors.borderColor, width: 1.w),
                  ),
                ),
                showCountryFlag: true,
                initialCountryCode: 'US',
                flagsButtonMargin: EdgeInsets.only(left: 10.w),
                disableLengthCheck: true,
                dropdownIconPosition: IconPosition.trailing,
                onChanged: (phone) {
                  print("Phone===============> ${phone.completeNumber}");
                },
              ),
              SizedBox(height: 32.h),
              //========================> Send OTP Button <==================
              CustomButton(onTap: () {
                Get.toNamed(AppRoutes.otpScreen);
              }, text: AppStrings.sendOTP.tr),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
