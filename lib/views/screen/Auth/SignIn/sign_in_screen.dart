import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ride_sharing/utils/app_icons.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 104.h),
                Center(child: Image.asset(AppImages.appLogo, width: 91.w, height: 94.h)),
                SizedBox(height: 24.h),
                //========================> Sign In Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.signIn.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 55.w,
                          height: 8.h,
                          child: Divider(
                            thickness: 5.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: AppStrings.toYourAccount.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Sign In Sub Title <==================
                SizedBox(height: 14.h),
                Center(child: CustomText(text: AppStrings.welcomeSignInToYourAccount.tr, maxLine: 3)),
                //=============================> Phone number Text Field <====================
                SizedBox(height: 32.h),
                CustomText(
                  text: AppStrings.phoneNumber.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  controller: _authController.signInEmailCtrl,
                  hintText: AppStrings.enterEmail.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email".tr;
                    }
                    return null;
                  },
                ),
                //========================> Password Text Field <==================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.password.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  isPassword: true,
                  controller: _authController.signInPassCtrl,
                  hintText: AppStrings.password.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    return null;
                  },
                ),
                //========================> Forgot Passwords Button <==================
                SizedBox(height: 16.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: CustomText(
                      text: AppStrings.forgotPasswords.tr,
                      fontWeight: FontWeight.w500,
                      bottom: 32.h,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ),
                //========================> Sign in Button <==================
                Obx(()=> CustomButton(
                  loading: _authController.signInLoading.value,
                      onTap: () {
                    _authController.signIn();
                  }, text: AppStrings.signIn.tr),
                ),
                SizedBox(height: 32.h),
                //========================> Don’t have an account Sign Up Button <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppStrings.donotHaveAnAccount.tr),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.selectRoleScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signUp.tr,
                        fontWeight: FontWeight.w600,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
