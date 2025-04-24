import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_strings.dart';
import '../../../../../base/custom_app_bar.dart';
import '../../../../../base/custom_network_image.dart';
import '../../../../../base/custom_text.dart';

class DriverPersonalInformationScreen extends StatelessWidget {
  const DriverPersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.personalInformation.tr),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==============================> Profile picture section <=======================
            Stack(
              children: [
                CustomNetworkImage(
                  imageUrl:
                      'https://s3-alpha-sig.figma.com/img/aba5/7875/06b6763c27225f414df7f949639fd20d?Expires=1745798400&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=BIM9NpRoedGzbRmOCOQwiVNR5~KnNHQyU-~zHD-zQ6niilUr5LM73jnCiN8Gii6tQL~UNbROSw4ojYsBWp6PBzymehTvt~3qZoXlGoIHavo7uIxXMKyK3Vxv~4Kls0MRboaDlqlZWbyTVGQzXuf~T08jG~Rvm5iPK8WATnHVZ-WmE5m0Ysf9eklTkd3JPZd4jyaA6W1twcCM6H2erKBSI0F~SroPsU3JRjet9LxsAIfT1FERORU~z~9MSbXzLWSB-ms98Ns2Ey0YYuSi1ceWrW~oCW9ASwMmYx~LQMJGCjJPfHHRCBVRGx3azfGrtqmxBbasTwGuKx~rHG8wUAIUAw__',
                  height: 369.h,
                  width: 402.w,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                //==============================> Edit Profile Button <=======================
                Positioned(
                  right: 16.w,
                  top: 16.h,
                  child: InkWell(
                    onTap: () {
                      //  Get.toNamed(AppRoutes.editProfileScreen);
                    },
                    child: SvgPicture.asset(AppIcons.edit),
                  ),
                ),
              ],
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
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 12.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //=====================> Name and Gender Row <=================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Bashar islam',
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 3,
                                  bottom: 8.h,
                                ),
                                CustomText(text: 'Male'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      //=====================> Email Row <=================
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: AppStrings.email.tr,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 3,
                                  bottom: 8.h,
                                ),
                                CustomText(
                                  text: 'abe@gmail.com',
                                  maxLine: 5,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      //=====================> Phone Number Row <=================
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: AppStrings.phoneNumber.tr,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 3,
                                  bottom: 8.h,
                                ),
                                CustomText(
                                  text: '(444) 555-9999',
                                  maxLine: 5,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      //=====================> Location and Distance Row <=================
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: AppStrings.location.tr,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 3,
                                  bottom: 8.h,
                                ),
                                CustomText(
                                  text: 'Chicago, IL United States',
                                  maxLine: 5,
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      //========================> Driving license photo Section <==========================
                      CustomText(
                        text: AppStrings.drivingLicensePhoto.tr,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      SizedBox(height: 16.h),
                      CustomNetworkImage(
                        imageUrl: '',
                        height: 197.h,
                        width: 362.w,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      SizedBox(height: 16.h),
                      CustomNetworkImage(
                        imageUrl: '',
                        height: 197.h,
                        width: 362.w,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
