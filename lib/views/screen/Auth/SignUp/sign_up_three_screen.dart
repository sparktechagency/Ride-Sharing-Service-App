import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ride_sharing/controllers/profile_controller.dart';
import 'package:ride_sharing/helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/dotted_border_container.dart';

class SignUpThreeScreen extends StatefulWidget {
  const SignUpThreeScreen({super.key});

  @override
  State<SignUpThreeScreen> createState() => _SignUpThreeScreenState();
}

class _SignUpThreeScreenState extends State<SignUpThreeScreen> {
  final ProfileController _profileController = Get.put(ProfileController());

  Uint8List? frontSiteImage;
  Uint8List? backSiteImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //======================> Front side image upload section <===========================
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: AppStrings.greenCardDrivingLicenseFrontSide.tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      bottom: 16.h,
                    ),
                    DottedBorderContainer(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child:
                            frontSiteImage != null
                                ? Image.memory(
                                  frontSiteImage!,
                                  fit: BoxFit.cover,
                                )
                                : _addImageButton('frontSite'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
            //=======================> Back side image upload section <===========================
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.w, color: AppColors.borderColor),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: AppStrings.greenCardDrivingLicenseBackSide.tr,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      bottom: 16.h,
                    ),
                    DottedBorderContainer(
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child:
                            backSiteImage != null
                                ? Image.memory(
                                  backSiteImage!,
                                  fit: BoxFit.cover,
                                )
                                : _addImageButton('backSite'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //========================> Back And Next Button <==================
            SizedBox(height: 32.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  onTap: () {
                    Get.back();
                  },
                  text: AppStrings.back.tr,
                  height: 48.h,
                  width: 158.w,
                  color: Colors.white,
                  textColor: AppColors.primaryColor,
                ),
                CustomButton(
                  onTap: () {Get.toNamed(AppRoutes.otpScreen);},
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
    );
  }
  //===============================> Add Image Button <=========================
  _addImageButton(String imageType) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            text: 'Choose a file or drag & drop it here'.tr,
            maxLine: 3,
            color: Colors.grey,
          ),
          CustomButton(
            onTap: () async {
              final Uint8List? imageBytes = await _profileController
                  .pickTypeImage(ImageSource.gallery, imageType);
              if (imageBytes != null) {
                setState(() {
                  if (imageType == 'frontSite') {
                    frontSiteImage = imageBytes;
                  } else if (imageType == 'backSite') {
                    backSiteImage = imageBytes;
                  }
                });
              } else {
                debugPrint("No image selected");
              }
            },
            text: 'Browse File'.tr,
            fontSize: 12.sp,
            width: 98.w,
            height: 25.h,
          ),
        ],
      ),
    );
  }
}
