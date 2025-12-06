import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_strings.dart';
import '../../../../base/custom_network_image.dart';
import '../../../../base/custom_text.dart';
import '../../../../base/custom_text_field.dart';
import '../BottomNavBar/driver_bottom_menu..dart';


class DriverInboxScreen extends StatelessWidget {
  DriverInboxScreen({super.key});
  final TextEditingController _searchCTRL = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: DriverBottomMenu(2),
      appBar: AppBar(title: Text('Chats'.tr)),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //==========================> Search Bar <==========================
            CustomTextField(
              
              controller: _searchCTRL,
              hintText: AppStrings.search.tr,
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Icon(Icons.search, color: Colors.grey),
              ),
            ),
            SizedBox(height: 16.h),
            //=============================> Chats List <====================================
            Expanded(
              flex: 5,
              child: ListView.builder(
                shrinkWrap: true,
                addAutomaticKeepAlives: false,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoutes.driverMessageScreen);
                      },
                      child: Padding(
                        padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                        child: Row(
                          children: [
                            CustomNetworkImage(
                              imageUrl:
                              'https://t4.ftcdn.net/jpg/02/24/86/95/360_F_224869519_aRaeLneqALfPNBzg0xxMZXghtvBXkfIA.jpg',
                              height: 56.h,
                              width: 56.w,
                              boxShape: BoxShape.circle,
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //=====================> Name <=======================
                                  CustomText(
                                    text: 'Rida Anam',
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w700,
                                    bottom: 6.h,
                                    maxLine: 2,
                                    textAlign: TextAlign.start,
                                  ),
                                  //=====================> Last Message <=======================
                                  CustomText(
                                    text: 'Hello, are you here?',
                                    fontWeight: FontWeight.w500,
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            //==========================> Time and Unread Count Column <========================
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomText(
                                  text: '7:09 PM',
                                  fontSize: 12.sp,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  padding: EdgeInsets.all(6.w),
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    shape: BoxShape.circle,
                                  ),
                                  child: CustomText(
                                    text: '99+',
                                    fontSize: 12.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
