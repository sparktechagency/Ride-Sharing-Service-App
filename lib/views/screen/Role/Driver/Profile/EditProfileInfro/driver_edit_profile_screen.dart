import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../controllers/profile_controller.dart';
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
  final ProfileController _controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //==============================> Profile picture section <=======================
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl:
                      'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                  height: 135.h,
                  width: 135.w,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(width: 2.w, color: AppColors.primaryColor),
                ),
                //==============================> Edit Profile Button <=======================
                Positioned(
                  right: 0.w,
                  bottom: 0.h,
                  child: InkWell(
                    onTap: () {
                      _showImagePickerOption();
                    },
                    child: SvgPicture.asset(AppIcons.edit),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),
            //==============================> Container Text Field <=======================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //====================> User Name Text Field <================
                      CustomText(
                        text: AppStrings.userName.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        controller: _controller.userNameCTRL,
                        hintText: AppStrings.userName.tr,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: SvgPicture.asset(AppIcons.profile),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      /*//====================> Phone Number Text Field <================
                      CustomText(
                        text: AppStrings.phoneNumber.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      IntlPhoneField(
                        decoration: InputDecoration(
                          hintText: "Phone number",
                          contentPadding:EdgeInsets.symmetric(horizontal: 12.h, vertical: 16.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            borderSide: BorderSide(color: AppColors.borderColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            borderSide: BorderSide(color: AppColors.borderColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.r)),
                            borderSide: BorderSide(color: AppColors.borderColor, width: 1.w),
                          ),
                        ),
                        showCountryFlag: true,
                        initialCountryCode: 'US',
                        flagsButtonMargin: EdgeInsets.only(left: 10.w),
                        disableLengthCheck: true,
                        dropdownIconPosition: IconPosition.trailing,
                        onChanged: (phone) {
                          print("Phone===============> ${phone.completeNumber}");
                        },
                      ),
                      SizedBox(height: 16.h),*/
                      //========================> Address Text Field <==================
                      CustomText(
                        text: AppStrings.address.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        controller: _controller.addressCtrl,
                        hintText: AppStrings.enterYourAddress.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.location),
                      ),
                      //========================> Date Of Birth Day Text Field <==================
                      SizedBox(height: 16.h),
                      CustomText(
                        text: AppStrings.dateOfBirth.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        onTab: () {
                          _controller.pickBirthDate(context);
                        },
                        readOnly: true,
                        controller: _controller.dateBirthCTRL,
                        hintText: AppStrings.dateOfBirth.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.calender),
                      ),
                      //========================> Vehicles type Text Field <==================
                      SizedBox(height: 16.h),
                      CustomText(
                        text: AppStrings.vehiclesType.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        controller: _controller.typeCTRL,
                        hintText: AppStrings.vehiclesType.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.type),
                      ),
                      //========================> Vehicles model Text Field <==================
                      SizedBox(height: 16.h),
                      CustomText(
                        text: AppStrings.vehiclesModel.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        controller: _controller.modelCTRL,
                        hintText: AppStrings.vehiclesModel.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.model),
                      ),
                      //========================> License plate Text Field <==================
                      SizedBox(height: 16.h),
                      CustomText(
                        text: AppStrings.licensePlate.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        bottom: 14.h,
                      ),
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: _controller.licenseCTRL,
                        hintText: AppStrings.typeNumber.tr,
                        prefixIcon: SvgPicture.asset(AppIcons.licenseNum),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 22.h),
            //==============================> Update profile Button <=======================
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w),
              child: CustomButton(onTap: (){}, text: AppStrings.updateProfile.tr),
            ),
            SizedBox(height: 22.h),

          ],
        ),
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
}
