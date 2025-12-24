import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController passCTRL = TextEditingController();
  final TextEditingController confirmPassCTRL = TextEditingController();
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
              children: [
                SizedBox(height: 164.h),
                Center(child: Image.asset(AppImages.appLogo, width: 91.w, height: 94.h)),
                SizedBox(height: 24.h),
                //========================> Reset Password Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.reset.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 56.w,
                          height: 8.h,
                          child: Divider(
                            thickness: 5.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: AppStrings.password.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Reset Password Sub Title <==================
                SizedBox(height: 14.h),
                CustomText(text: AppStrings.enterNewPassword.tr, maxLine: 3),
                //========================> Password Text Field <==================
                SizedBox(height: 32.h),
                CustomTextField(
                  isPassword: true,
                  controller: passCTRL,
                  hintText: AppStrings.password.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    return null;
                  },

                ),
                //========================> Confirm Password Text Field <==================
                SizedBox(height: 16.h),
                CustomTextField(
                  isPassword: true,
                  controller: confirmPassCTRL,
                  hintText: AppStrings.confirmPassword.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 32.h),
                //========================> Reset Password Button <==================
                Obx(()=> CustomButton(
                  loading: _authController.resetPasswordLoading.value,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _authController.resetPassword(
                              '${Get.parameters['email']}',
                              confirmPassCTRL.text
                          );
                        }
                  }, text: AppStrings.resetPassword.tr),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //===============================> Password Changed! Bottom Sheet <===============================
  _showCustomBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r),
            ),
            border: Border(
              top: BorderSide(width: 2.w, color: AppColors.primaryColor),
            ),
            color: AppColors.cardColor,
          ),
          height: 265.h,
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: AppStrings.passwordChanged.tr,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
              SizedBox(
                width: 215.w,
                child: Divider(color: AppColors.primaryColor),
              ),
              SizedBox(height: 20.h),
              CustomText(
                text: AppStrings.returnToTheLoginPage.tr,
                maxLine: 5,
              ),
              SizedBox(height: 20.h),
             CustomButton(onTap: (){
               Get.toNamed(AppRoutes.signInScreen);
             }, text: AppStrings.backToSignIn.tr)
            ],
          ),
        );
      },
    );
  }
}
