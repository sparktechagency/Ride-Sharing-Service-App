import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../controllers/license_upload_controller.dart';
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
  final LicenseUploadController _licenseUploadController = Get.put(LicenseUploadController());
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage(int index) async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _licenseUploadController.imagePaths[index] = pickedFile.path;
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      _licenseUploadController.imagePaths[index] = '';
    });
  }

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
              // Front Side
              _buildImageSection(
                title: AppStrings.greenCardDrivingLicenseFrontSide.tr,
                index: 0,
                onPick: () => pickImage(0),
              ),
              SizedBox(height: 16.h),

              // Back Side
              _buildImageSection(
                title: AppStrings.greenCardDrivingLicenseBackSide.tr,
                index: 1,
                onPick: () => pickImage(1),
              ),

              SizedBox(height: 24.h),

              // Submit Button
              Obx(() => CustomButton(
                loading: _licenseUploadController.uploadGalleryLoading.value,
                onTap: () {
                  final front = _licenseUploadController.imagePaths[0];
                  final back = _licenseUploadController.imagePaths[1];
                  if (front.isEmpty || back.isEmpty) {
                    Fluttertoast.showToast(
                        msg: 'Please pick both front and back sides of your license'.tr);
                    return;
                  }
                  _licenseUploadController.uploadLicenseImages();
                },
                text: AppStrings.next.tr,
              )),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageSection({
    required String title,
    required int index,
    required VoidCallback onPick,
  }) {
    return Container(
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
              text: title,
              fontSize: 16.sp,
              maxLine: 2,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w500,
              bottom: 16.h,
            ),
            DottedBorderContainer(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: _licenseUploadController.imagePaths[index].isNotEmpty
                    ? _buildImagePreview(_licenseUploadController.imagePaths[index])
                    : _addImageButton(onPick),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview(String imagePath) {
    return Image.file(
      File(imagePath),
      fit: BoxFit.cover,
    );
  }

  Widget _addImageButton(VoidCallback onPick) {
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
            onTap: onPick,
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