import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_app_bar.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/dotted_border_container.dart';

class DriverLicenceUploadScreen extends StatefulWidget {
  const DriverLicenceUploadScreen({super.key});

  @override
  State<DriverLicenceUploadScreen> createState() => _DriverLicenceUploadScreenState();
}

class _DriverLicenceUploadScreenState extends State<DriverLicenceUploadScreen> {
  final AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
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
                        maxLine: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        bottom: 16.h,
                      ),
                  DottedBorderContainer(
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: _authController.frontSiteImage != null
                          ? FutureBuilder<Uint8List>(
                        future: _authController.frontSiteImage!.readAsBytes(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Image.memory(
                                snapshot.data!,
                                fit: BoxFit.cover,
                              );
                            } else {
                              return Center(child: Text('No image available'));
                            }
                          } else {
                            return Center(child: CircularProgressIndicator());
                          }
                        },
                      )
                          : _addImageButton('frontSite'),
                    ),
                  )
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
                        maxLine: 2,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        bottom: 16.h,
                      ),
                      DottedBorderContainer(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: _authController.backSiteImage != null
                              ? FutureBuilder<Uint8List>(
                            future: _authController.backSiteImage!.readAsBytes(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasData) {
                                  return Image.memory(
                                    snapshot.data!,
                                    fit: BoxFit.cover,
                                  );
                                } else {
                                  return Center(child: Text('No image available'));
                                }
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          )
                              : _addImageButton('backSite'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //========================> Back And Next Button <==================
              SizedBox(height: 24.h),
                  Obx(()=> CustomButton(
                    loading: _authController.driverSignUpLoading.value,
                      onTap: () {
                        if (_authController.backSiteImage != null || _authController.backSiteImage != null ) {
                          _authController.driverSignUp();
                        }else {
                          Fluttertoast.showToast(
                              msg: 'Please pick your license front and back sides'.tr);
                        }
                      },
                      text: AppStrings.next.tr,
                    ),
                  ),

              SizedBox(height: 16.h),
            ],
          ),
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
              final File? imageFile = await _authController.pickTypeImage(ImageSource.gallery, imageType);
              if (imageFile != null) {
                setState(() {
                  if (imageType == 'frontSite') {
                    _authController.frontSiteImage = imageFile;
                    _authController.frontSitePath.value = imageFile.path;
                  } else if (imageType == 'backSite') {
                    _authController.backSiteImage = imageFile;
                    _authController.backSitePaths.value = imageFile.path;
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
