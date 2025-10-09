import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../controllers/auth_controller.dart';
import '../../../../helpers/route.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_icons.dart';
import '../../../../utils/app_images.dart';
import '../../../../utils/app_strings.dart';
import '../../../base/custom_button.dart';
import '../../../base/custom_text.dart';
import '../../../base/custom_text_field.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final AuthController _authController = Get.put(AuthController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 64.h),
                Center(child: Image.asset(AppImages.appLogo, width: 91.w, height: 94.h)),
                SizedBox(height: 24.h),
                //========================> Sign up Title <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomText(
                          text: AppStrings.signUp.tr,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        SizedBox(
                          width: 65.w,
                          height: 8.h,
                          child: Divider(
                            thickness: 5.5,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    CustomText(
                      text: AppStrings.withEmail.tr,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      bottom: 6.h,
                    ),
                  ],
                ),
                //========================> Sign up Sub Title <==================
                SizedBox(height: 14.h),
                Center(
                  child: CustomText(text: AppStrings.welcomeBackPleaseEnter.tr, maxLine: 3),
                ),
                //========================> Name Text Field <==================
                SizedBox(height: 32.h),
                CustomText(
                  text: AppStrings.userName.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  controller: _authController.userNameCtrl,
                  hintText: AppStrings.userName.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.profile),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your user name".tr;
                    }
                    return null;
                  },
                ),
                //========================> email Text Field <==================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.email.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  controller: _authController.userEmailCtrl,
                  hintText: AppStrings.enterEmail.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.email),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email".tr;
                    }
                    return null;
                  },
                ),
                //=============================> Phone number Text Field <====================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.phoneNumber.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                IntlPhoneField(
                  controller: _authController.userNumberCtrl,
                  decoration: InputDecoration(
                    hintText: "Phone number".tr,
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
                  validator: (value) {
                    if (value == null) {
                      return "Please enter your phone number".tr;
                    }
                    return null;
                  },
                  showCountryFlag: true,
                  initialCountryCode: 'US',
                  flagsButtonMargin: EdgeInsets.only(left: 10.w),
                  disableLengthCheck: true,
                  dropdownIconPosition: IconPosition.trailing,
                  onChanged: (phone) {
                    print("Phone===============> ${phone.completeNumber}");
                  },
                ),
                //========================> Password Text Field <==================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.password.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  isPassword: true,
                  controller: _authController.userPasswordCtrl,
                  hintText: AppStrings.password.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password".tr;
                    }
                    return null;
                  },
                ),
                //========================> Confirm Password Text Field <==================
                SizedBox(height: 16.h),
                CustomText(
                  text: AppStrings.confirmPassword.tr,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  bottom: 14.h,
                ),
                CustomTextField(
                  isPassword: true,
                  controller: _authController.userConfirmCtrl,
                  hintText: AppStrings.confirmPassword.tr,
                  prefixIcon: SvgPicture.asset(AppIcons.lock),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password".tr;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                _checkboxSection(),
                SizedBox(height: 16.h),
                //========================> Sign Up Button <==================
                Obx(()=> CustomButton(
                  loading: _authController.userSignUpLoading.value,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        if (isChecked ) {
                            _authController.userSignUp();}
                        else {
                          Fluttertoast.showToast(
                              msg: 'Please accept Terms & Conditions'.tr);
                        }
                      }
                    },
                    text: AppStrings.signUp.tr,
                  ),
                ),


                SizedBox(height: 16.h),
                //========================> Don’t have an account Sign In Button <==================
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(text: AppStrings.alreadyHaveAnAccount.tr),
                    SizedBox(width: 4.w),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.signInScreen);
                      },
                      child: CustomText(
                        text: AppStrings.signIn.tr,
                        fontWeight: FontWeight.w600,
                        textDecoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //==========================> Checkbox Section Widget <=======================
  _checkboxSection() {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          activeColor: AppColors.primaryColor,
          focusColor: AppColors.greyColor,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          side: BorderSide(
            color: isChecked ? AppColors.primaryColor : AppColors.primaryColor,
            width: 1.w,
          ),
        ),
        Text.rich(
          maxLines: 3,
          TextSpan(
            text: AppStrings.byCreatingAnAccountIAccept.tr,
            style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: AppStrings.termsConditions.tr,
                style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.bold),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.termsServicesScreen);
                      },
              ),
              const TextSpan(text: ' & '),
              TextSpan(
                text: AppStrings.privacyPolicy.tr,
                style: TextStyle(fontSize: 12.w, fontWeight: FontWeight.bold),
                recognizer:
                    TapGestureRecognizer()
                      ..onTap = () {
                        Get.toNamed(AppRoutes.privacyPolicyScreen);
                      },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
