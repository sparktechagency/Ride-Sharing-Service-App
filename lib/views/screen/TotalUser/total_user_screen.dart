import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_icons.dart';
import '../../../utils/app_strings.dart';
import '../../base/custom_app_bar.dart';
import '../../base/custom_network_image.dart';
import '../../base/custom_text.dart';

class TotalUserScreen extends StatelessWidget {
  const TotalUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.totalUser.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(
                  bottom: 12.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    width: 1.w,
                    color: AppColors.borderColor,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //=====================> Name & Image Row <=================
                      Row(
                        children: [
                          CustomNetworkImage(
                            imageUrl:
                            'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                            height: 54.h,
                            width: 54.w,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Mr. Imran',
                                bottom: 4.h,
                                fontWeight: FontWeight.w500,
                              ),
                              CustomText(
                                text: 'Location: Dhaka to Rangpur',
                                right: 4.w,
                              ),
                            ],
                          ),
                          Spacer(),
                          //=====================> Review & Star Row <=================
                          Row(
                            children: [
                              CustomText(
                                text: '4.9',
                                fontSize: 18.sp,
                                right: 4.w,
                              ),
                              SvgPicture.asset(AppIcons.star),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
