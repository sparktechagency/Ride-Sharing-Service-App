import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_button.dart';
import '../../base/custom_text.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  List<bool> selectedRole = [false, false];

  final List<Map<String, String>> modeOptions = [
    {
      'icon': 'person',
      'title': AppStrings.user.tr,
      'subtitle': AppStrings.createYourAccountAsUser.tr,
    },
    {
      'icon': 'person',
      'title': AppStrings.driver.tr,
      'subtitle': AppStrings.createYourAccountAndBeginYourJourneyDriver.tr,
    },
  ];

  void onModeSelected(int index) {
    setState(() {
      selectedRole = List.generate(modeOptions.length, (i) => i == index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: Align(
          alignment: Alignment.centerRight,
          child: CustomText(
            text: AppStrings.skip.tr,
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            textDecoration: TextDecoration.underline,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 104.h),
              CustomText(
                text: AppStrings.joinAs.tr,
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                bottom: 16.h,
              ),
              CustomText(
                text: AppStrings.pleaseSelectAnOneOption.tr,
                fontWeight: FontWeight.w400,
                fontSize: 14.sp,
                maxLine: 3,
                bottom: 32.h,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: modeOptions.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onModeSelected(index),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          color:
                              selectedRole[index]
                                  ? AppColors.primaryColor.withOpacity(0.1)
                                  : const Color(0xFFE5F4F9),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color:
                                selectedRole[index]
                                    ? AppColors.primaryColor
                                    : Colors.transparent,
                            width: 2.w,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 12.w,
                              height: 99.h,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12.r),
                                  bottomLeft: Radius.circular(12.r),
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            // Profile Icon
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFD1EBF4),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                Icons.person,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: modeOptions[index]['title']!,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  SizedBox(height: 4.h),
                                  CustomText(
                                    text: modeOptions[index]['subtitle']!,
                                    fontSize: 14.sp,
                                    maxLine: 3,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            //====================> Custom Checkbox Design <=======================
                            Checkbox(
                              value: selectedRole[index],
                              onChanged: (value) => onModeSelected(index),
                              activeColor: AppColors.primaryColor,
                              checkColor: Colors.white,
                              side: BorderSide(color: AppColors.primaryColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              //=========================> Continue Button <====================
              CustomButton(onTap: () {
                if(selectedRole.first){
                  Get.offAllNamed(AppRoutes.userSearchScreen);
                } else {
                  Get.offAllNamed(AppRoutes.driverHomeScreen);
                }
                }, text: AppStrings.continues.tr),
              SizedBox(height: 58.h),
            ],
          ),
        ),
      ),
    );
  }
}
