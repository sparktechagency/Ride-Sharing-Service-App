import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPassCTRL = TextEditingController();
  final TextEditingController _passCTRL = TextEditingController();
  final TextEditingController _confirmPassCTRL = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.changePassword.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              //==========================> Current password Text Field <===================
              CustomTextField(
                isPassword: true,
                controller: _oldPassCTRL,
                hintText: AppStrings.oldPassword.tr,
              ),
              SizedBox(height: 16.h),
              //==========================> New password Text Field <===================
              CustomTextField(
                isPassword: true,
                controller: _passCTRL,
                hintText: AppStrings.newPassword.tr,
              ),
              SizedBox(height: 16.h),
              //==========================> Confirm Password Text Field <===================
              CustomTextField(
                isPassword: true,
                controller: _confirmPassCTRL,
                hintText: AppStrings.confirmPassword.tr,
              ),
              SizedBox(height: 268.h),
              //==========================> Update Password Button <=======================
              CustomButton(onTap: () {}, text: AppStrings.updatePassword.tr),
            ],
          ),
        ),
      ),
    );
  }
}
