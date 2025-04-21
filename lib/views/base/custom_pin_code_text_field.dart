import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../../../utils/app_colors.dart';

class CustomPinCodeTextField extends StatelessWidget {
  const CustomPinCodeTextField({super.key,this.textEditingController});
  final TextEditingController? textEditingController;
  @override
  Widget build(BuildContext context) {
    return  PinCodeTextField(
      backgroundColor: Colors.transparent,
      cursorColor: AppColors.primaryColor,
      controller: textEditingController,
      textStyle: TextStyle(color: Colors.black),
      autoFocus: false,
      appContext: context,
      length: 6,
      pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          selectedColor: AppColors.primaryColor,
          activeFillColor: AppColors.primaryColor,
          selectedFillColor: AppColors.greyColor,
          inactiveFillColor: AppColors.primaryColor,
          fieldHeight: 57.h,
          fieldWidth: 44.w,
          inactiveColor: AppColors.primaryColor,
          activeColor: AppColors.primaryColor),
      obscureText: false,
      keyboardType: TextInputType.number,
      onChanged: (value) {},
    );
  }
}