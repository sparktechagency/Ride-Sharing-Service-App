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


class UserEditProfileScreen extends StatefulWidget {
  const UserEditProfileScreen({super.key});

  @override
  State<UserEditProfileScreen> createState() => _UserEditProfileScreenState();
}

class _UserEditProfileScreenState extends State<UserEditProfileScreen> {
  final ProfileController _controller = Get.put(ProfileController());

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
            _buildField(AppStrings.phoneNumber.tr, _controller.phoneCTRL, AppIcons.call),
            _buildField(AppStrings.dateOfBirth.tr, _controller.dateBirthCTRL, AppIcons.calender,
                readOnly: true, onTap: () => _controller.pickBirthDate(context)),

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

  //====================================> Pick Image Gallery and Camera <====================
  void _showImagePickerOption() {
    showModalBottomSheet(
      backgroundColor: AppColors.whiteColor,
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              //=========================> Pick Image Gallery <==================
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _controller.pickImage(ImageSource.gallery);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Gallery',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),
              //=========================> Pick Image Camera <====================
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _controller.pickImage(ImageSource.camera);
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.camera_alt,
                          size: 50.w, color: AppColors.primaryColor),
                      SizedBox(height: 8.h),
                      CustomText(
                        text: 'Camera',
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16.sp,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
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
}
