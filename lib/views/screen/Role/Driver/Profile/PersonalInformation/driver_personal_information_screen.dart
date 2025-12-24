import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../../controllers/profile_controller.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../service/api_constants.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_page_loading.dart';
import '../../../../../base/custom_text.dart';
import '../../../../Auth/DriverSignUp/driver_licence_upload_screen.dart';

class DriverPersonalInformationScreen extends StatefulWidget {
  const DriverPersonalInformationScreen({super.key});

  @override
  State<DriverPersonalInformationScreen> createState() => _DriverPersonalInformationScreenState();
}

class _DriverPersonalInformationScreenState extends State<DriverPersonalInformationScreen> {
  late ProfileController _profileController;

  @override
  void initState() {
    super.initState();
    _profileController = Get.put(ProfileController());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _profileController.getProfileData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: Obx(() =>
      _profileController.profileLoading.value
          ? const Center(child: CustomPageLoading())
          :  SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================> Profile picture section <=======================
            Center(
              child: CustomNetworkImage(
                imageUrl: '${ApiConstants.imageBaseUrl}${_profileController.profileModel.value.image ?? ''}',
                height: 135.h,
                width: 135.w,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(width: 2.w, color: AppColors.primaryColor),
              ),
            ),
            SizedBox(height: 32.h),
            //==============================> My Bio section <=======================
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //=====================> Personal Information <=================
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      child: CustomText(
                        text: AppStrings.personalInformation.tr,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Divider(thickness: 1.w, color: AppColors.borderColor),
                    //=====================> Details Information <=================
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w, vertical: 12.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.driverEditProfileScreen);
                              },
                              child: CustomText(
                                text: AppStrings.editProfile.tr,
                                fontWeight: FontWeight.w500,
                                textDecoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 14.h),
                          //=====================> Name and Gender Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.profile),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: AppStrings.name.tr,
                                        ),
                                        CustomText(
                                          text: _profileController.profileModel.value.userName ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Phone Number Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.mail),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.email.tr
                                        ),
                                        CustomText(
                                          text: _profileController.profileModel.value.email ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Phone Number Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.call),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.phoneNumber.tr
                                        ),
                                        CustomText(
                                          text: _profileController.profileModel.value.phoneNumber ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Location and Distance Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.location),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.location.tr
                                        ),
                                        CustomText(
                                          text: _profileController.profileModel.value.address ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Date of Birth Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.calender),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.dateOfBirth.tr
                                        ),
                                        CustomText(
                                          text: DateFormat('yyyy-MM-dd').format(
                                            DateTime.parse('${_profileController.profileModel.value.dateOfBirth ?? 'N/A'}')),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Vehicles Type Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.type),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.vehiclesType.tr
                                        ),
                                        CustomText(
                                          text: '${(_profileController.profileModel.value.vehicleType ?? 'N/A').capitalize}',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> Vehicles Model Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.car, color: Colors.grey),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.vehiclesModel.tr
                                        ),
                                        CustomText(
                                          text: '${(_profileController.profileModel.value.vehicleModel ?? 'N/A').capitalize}',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          //=====================> License Plate Row <=================
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    SvgPicture.asset(AppIcons.licenseNum),
                                    SizedBox(width: 12.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                            text: AppStrings.licensePlate.tr
                                        ),
                                        CustomText(
                                          text: _profileController.profileModel.value.licensePlateNumber ?? 'N/A',
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w500,
                                          maxLine: 3,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //========================> Driving license photo Section <==========================
                  // Inside DriverPersonalInformationScreen, find the Driving license photo Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: AppStrings.drivingLicensePhoto.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      InkWell(
                        onTap: () {
                          // Navigate to the new Edit License Screen
                          Get.toNamed(
                              AppRoutes.driverLicenceUploadScreen,
                              arguments: {"isFromProfile": true}
                          );

                        },
                        child: CustomText(
                          text: AppStrings.editProfile.tr, // Or use "Edit License"
                          fontWeight: FontWeight.w500,
                          textDecoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  CustomNetworkImage(
                    imageUrl: '${ApiConstants.imageBaseUrl}/${_profileController.profileModel.value.licenseFrontUrl ?? ''}',
                    height: 197.h,
                    width: 362.w,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  SizedBox(height: 16.h),
                  CustomNetworkImage(
                    imageUrl: '${ApiConstants.imageBaseUrl}/${_profileController.profileModel.value.licenseBackUrl ?? ''}',
                    height: 197.h,
                    width: 362.w,
                    borderRadius: BorderRadius.circular(16.r),
                  ),

                ],
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
      ),
    );
  }
}