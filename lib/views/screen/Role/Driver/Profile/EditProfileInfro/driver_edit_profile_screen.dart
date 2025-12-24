import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../controllers/profile_controller.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_button.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';
import '../../../../../base/custom_text_field.dart';


class DriverEditProfileScreen extends StatefulWidget {
  const DriverEditProfileScreen({super.key});

  @override
  State<DriverEditProfileScreen> createState() => _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  final ProfileController _controller = Get.find<ProfileController>();

  @override
  void initState() {
    super.initState();
    _fillExistingData();
  }

  void _fillExistingData() {
    var data = _controller.profileModel.value;
    _controller.userNameCTRL.text = data.userName ?? '';
    _controller.addressCtrl.text = data.address ?? '';
    _controller.typeCTRL.text = data.vehicleType ?? '';
    _controller.modelCTRL.text = data.vehicleModel ?? '';
    _controller.licenseCTRL.text = data.licensePlateNumber ?? '';
    _controller.phoneCTRL.text = data.phoneNumber ?? '';

    if (data.dateOfBirth != null && data.dateOfBirth.toString().isNotEmpty) {
      try {
        DateTime parsedDate = DateTime.parse(data.dateOfBirth.toString());
        _controller.dateBirthCTRL.text = DateFormat('yyyy-MM-dd').format(parsedDate);
      } catch (e) {
        _controller.dateBirthCTRL.text = data.dateOfBirth.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 30.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            _buildProfileImage(),
            SizedBox(height: 22.h),
            _buildFormContainer(),
            SizedBox(height: 30.h),
            _buildUpdateButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Stack(
        children: [
          Obx(() => Container(
            height: 135.h, width: 135.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(width: 2.w, color: AppColors.primaryColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(22.r),
              child: _controller.imagesPath.value.isNotEmpty
                  ? Image.file(File(_controller.imagesPath.value), fit: BoxFit.cover)
                  : CustomNetworkImage(
                imageUrl: '${ApiConstants.imageBaseUrl}${_controller.profileModel.value.image ?? ''}',
                height: 135.h, width: 135.w,
              ),
            ),
          )),
          Positioned(
            right: 0, bottom: 0,
            child: InkWell(
              onTap: _showImagePickerOption,
              child: SvgPicture.asset(AppIcons.edit),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormContainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(width: 1.w, color: AppColors.borderColor),
        ),
        child: Column(
          children: [
            _buildField(AppStrings.userName.tr, _controller.userNameCTRL, AppIcons.profile),
            _buildField(AppStrings.address.tr, _controller.addressCtrl, AppIcons.location),
            _buildField(AppStrings.dateOfBirth.tr, _controller.dateBirthCTRL, AppIcons.calender,
                readOnly: true, onTap: () => _controller.pickBirthDate(context)),
            _buildField(AppStrings.vehiclesType.tr, _controller.typeCTRL, AppIcons.type),
            _buildField(AppStrings.vehiclesModel.tr, _controller.modelCTRL, AppIcons.model),
            _buildField(AppStrings.licensePlate.tr, _controller.licenseCTRL, AppIcons.licenseNum,
                keyboardType: TextInputType.number),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController ctrl, String icon, {bool readOnly = false, VoidCallback? onTap, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: label, fontSize: 16.sp, fontWeight: FontWeight.w500, bottom: 8.h, top: 12.h),
        CustomTextField(
          controller: ctrl, readOnly: readOnly, onTab: onTap,
          keyboardType: keyboardType, hintText: label,
          prefixIcon: Padding(padding: EdgeInsets.all(12.w), child: SvgPicture.asset(icon)),
        ),
      ],
    );
  }

  Widget _buildUpdateButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Obx(() => CustomButton(
        onTap: () => _controller.updateProfile(context),
        text: AppStrings.updateProfile.tr,
        loading: _controller.isUpdateLoading.value,
      )),
    );
  }

  void _showImagePickerOption() {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(text: "Update Profile Photo", fontSize: 18.sp, fontWeight: FontWeight.bold, bottom: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _pickerTile(Icons.image, "Gallery", ImageSource.gallery),
                _pickerTile(Icons.camera_alt, "Camera", ImageSource.camera),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pickerTile(IconData icon, String title, ImageSource source) {
    return InkWell(
      onTap: () => _controller.pickImage(source),
      child: Column(children: [Icon(icon, size: 40, color: AppColors.primaryColor), Text(title)]),
    );
  }
}