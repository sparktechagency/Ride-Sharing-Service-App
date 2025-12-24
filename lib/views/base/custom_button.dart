import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import '../../utils/app_colors.dart';
import '../../utils/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.textColor,
    this.broderColor,
    this.textStyle,
    this.padding = EdgeInsets.zero,
    required this.onTap,
    required this.text,
    this.loading = false, // This is your optional loading part
    this.width,
    this.fontSize,
    this.height,
  });

  final Function() onTap;
  final String text;
  final bool loading;
  final double? height;
  final double? width;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? broderColor;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        // Setting to null disables the button visually and functionally during loading
        onPressed: loading ? null : onTap,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: (color ?? AppColors.primaryColor).withOpacity(0.6),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1.w,
                color: loading
                    ? (broderColor ?? AppColors.primaryColor).withOpacity(0.5)
                    : (broderColor ?? AppColors.primaryColor)
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          backgroundColor: color ?? AppColors.primaryColor,
          minimumSize: Size(width ?? Get.width, height ?? 53.h),
        ),
        child: loading
            ? SizedBox(
          height: 20.h,
          width: 20.h,
          child: CircularProgressIndicator(
            color: textColor ?? Colors.white,
            strokeWidth: 2.w,
          ),
        )
            : CustomText(
          text: text,
          fontWeight: FontWeight.w500,
          fontSize: fontSize ?? 16.sp,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}