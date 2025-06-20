import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';
import 'package:ride_sharing/views/base/custom_text_field.dart';
import '../../../../../../helpers/route.dart';
import '../../../../../../utils/app_icons.dart';
import '../../../../../../utils/app_images.dart';
import '../BottomNavBar/user_bottom_menu..dart';

class UserSearchScreen extends StatelessWidget {
  UserSearchScreen({super.key});
  final TextEditingController pickUpCTRL = TextEditingController();
  final TextEditingController dropOffCTRL = TextEditingController();
  final TextEditingController dateCTRL = TextEditingController();
  final TextEditingController passengerCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UserBottomMenu(0),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(AppImages.appLogo, width: 62.w, height: 52.h),
            Spacer(),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.notificationsScreen);
              },
              child: SvgPicture.asset(AppIcons.notification),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //================================> Search Container <=======================
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(width: 1.w, color: AppColors.borderColor),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    children: [
                      //================================> Pick Up TextField <=======================
                      CustomTextField(
                        controller: pickUpCTRL,
                        hintText: AppStrings.pICKUP.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.location,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //================================> DROP OFF TextField <=======================
                      CustomTextField(
                        controller: dropOffCTRL,
                        hintText: AppStrings.dROPOFF.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.location,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //================================> Date TextField <=======================
                      CustomTextField(
                        onTab: ()=> pickDate(context),
                        readOnly: true,
                        controller: dateCTRL,
                        hintText: 'Select Date'.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.calender,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //================================> Passenger TextField <=======================
                      CustomTextField(
                        keyboardType: TextInputType.number,
                        controller: passengerCTRL,
                        hintText: 'Passenger'.tr,
                        prefixIcon: SvgPicture.asset(
                          AppIcons.profileOutline,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      //================================> Search Button <=======================
                      CustomButton(
                        onTap: () {
                          Get.toNamed(AppRoutes.seeAllScreen);
                        },
                        height: 45.h,
                        text: AppStrings.search.tr,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              //================================> Recently Search <=======================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: AppStrings.recentSearch.tr,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  //================================> See All Button <=======================
                  InkWell(
                    onTap: () {Get.toNamed(AppRoutes.seeAllScreen);},
                    child: CustomText(
                      text: AppStrings.seeAll.tr,
                      fontWeight: FontWeight.w500,
                      textDecoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              //================================> List View <=======================
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Column(
                        children: [
                          //========================> Top Container <=================
                          Padding(
                            padding: EdgeInsets.all(10.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      AppIcons.clock,
                                      color: AppColors.primaryColor,
                                    ),
                                    SizedBox(width: 8.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            CustomText(
                                              text: 'Dhaka',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                            ),
                                            SizedBox(width: 8.w),
                                            Icon(Icons.arrow_forward_outlined),
                                            SizedBox(width: 8.w),
                                            CustomText(
                                              text: 'Sylhet',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                            ),
                                          ],
                                        ),
                                        CustomText(
                                          text: 'Thu 10 Apr. 1 Passenger',
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                //========================> Status Container <=================
                                SvgPicture.asset(AppIcons.rightArrow),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  //==========================> Show Calender Function <=======================
  Future<void> pickDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(3050),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            dialogBackgroundColor: Colors.white,
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onSurface: Colors.black, // Text color
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null) {
      dateCTRL.text =
      "${pickedDate.month}-${pickedDate.day}-${pickedDate.year}";
    }
  }
}
