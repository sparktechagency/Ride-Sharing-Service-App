import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/helpers/route.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class DriverSignUpTwoScreen extends StatefulWidget {
  DriverSignUpTwoScreen({super.key});

  @override
  State<DriverSignUpTwoScreen> createState() => _DriverSignUpTwoScreenState();
}

class _DriverSignUpTwoScreenState extends State<DriverSignUpTwoScreen> {
  final AuthController _authController = Get.put(AuthController());

  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  List<String> vehiclesType = [
    'Car',
    'Bike',
    'Combi',
    'Moto',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //========================> Address Text Field <==================
                CustomText(
                  text: AppStrings.address.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  controller: _authController.addressCtrl,
                  hintText: AppStrings.enterYourAddress.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.location),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your address".tr;
                    }
                    return null;
                  },
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
                    _authController.pickBirthDate(context);
                  },
                  readOnly: true,
                  controller: _authController.dateOfBirthCtrl,
                  hintText: AppStrings.dateOfBirth.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.calender),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select your birth day".tr;
                    }
                    return null;
                  },
                ),
                //========================> Vehicles Type Dropdown Button <==================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.vehiclesType.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.w,
                    ),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: DropdownButton<String>(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    isExpanded: true,

                    dropdownColor: Colors.white,
                    value: _authController.selectedVehiclesType,
                    borderRadius: BorderRadius.circular(12.r),
                    hint:  CustomText(
                      left: 10.w,
                      text: 'Select Vehicles Type'.tr,
                      color: Colors.black,
                    ),
                    icon: SvgPicture.asset(AppIcons.rightArrow),
                    onChanged: (String? newValue) {
                      setState(() {
                        _authController.selectedVehiclesType = newValue;
                      });
                    },
                    underline: SizedBox(),
                    items: vehiclesType.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child:CustomText(
                          left: 10.w,
                          text: value,
                          color: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
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
                  controller: _authController.vehiclesModelCtrl,
                  hintText: AppStrings.vehiclesModel.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.model),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter vehicles model".tr;
                    }
                    return null;
                  },
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
                  controller: _authController.licenseNumberCtrl,
                  hintText: AppStrings.typeNumber.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.licenseNum),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter license number".tr;
                    }
                    return null;
                  },
                ),
                //========================> Back And Next Button <==================
                SizedBox(height: 98.h),
                    Obx(()=> CustomButton(
                      loading: _authController.driverSignUpLoading.value,
                        onTap: () {
                          if (_formKey2.currentState!.validate()) {
                            _authController.driverSignUp();
                          } else {
                            return null;
                          }
                        },
                        text: AppStrings.next.tr,
                        height: 48.h,
                        width: 158.w,
                      ),
                    ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
