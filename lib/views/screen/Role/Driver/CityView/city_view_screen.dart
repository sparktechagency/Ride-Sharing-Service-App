import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_strings.dart';
import 'package:ride_sharing/views/base/custom_app_bar.dart';
import 'package:ride_sharing/views/base/custom_button.dart';
import 'package:ride_sharing/views/base/custom_text.dart';

import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';

class CityViewScreen extends StatefulWidget {
  CityViewScreen({super.key});

  @override
  State<CityViewScreen> createState() => _CityViewScreenState();
}

class _CityViewScreenState extends State<CityViewScreen> {

  RxString date = 'Wed,Feb 12'.obs;
  RxString time = '5.23 PM'.obs;

  final List<Map<String, String>> items = [
    {'title': 'Dhaka', 'subtitle': 'Gabtoli Stand'},
    {'title': 'Mirpur', 'subtitle': 'Mirpur Doco C Block'},
    {'title': 'Rangpur', 'subtitle': 'Medical More Stand'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: ''),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: AppStrings.theseAreTheBestPlaces.tr,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              maxLine: 2,
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  bool isFirst = index == 0;
                  bool isLast = index == items.length - 1;
                  return IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Expanded(
                              child: Container(
                                width: 2,
                                color:
                                    isFirst ? Colors.transparent : Colors.grey,
                              ),
                            ),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                width: 2,
                                color:
                                    isLast ? Colors.transparent : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                items[index]['title'] ?? '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                items[index]['subtitle'] ?? '',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                              SizedBox(height: 24.h),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            CustomButton(onTap: () => _showPopup(context), text: AppStrings.next.tr),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  //================================> Show Popup Section <============================
  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: Obx(()=> Container(
              padding: EdgeInsets.all(20.w),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(AppIcons.cancel),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  //=============================> At what time will you pick passengers up ? <====================
                  CustomText(
                    text: AppStrings.atWhatTimeWillYouPick.tr,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    maxLine: 3,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 16.h),
                  //=================================> Timing <=========================
                  Center(
                    child: GestureDetector(
                      onTap: (){_pickDate(context);},
                      child: CustomText(
                        text: date.value ?? 'Wed, Feb 12',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Divider(thickness: 1.0, color: AppColors.borderColor),
                  SizedBox(height: 12.h),
                  Center(
                    child: GestureDetector(
                      onTap: (){selectTime(context);},
                      child: CustomText(
                        text: time.value ?? '5.23 PM',
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  //=============================> Next Button <====================
                  SizedBox(height: 16.h),
                  CustomButton(
                    onTap: () {
                      Get.toNamed(AppRoutes.cityViewScreen);
                    },
                    text: AppStrings.next.tr,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  //==========================> Show Calender Function <=======================
  Future<void> _pickDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
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
      setState(() {
        date.value = "${_getMonthName(pickedDate.month)} ${pickedDate.day}, ${pickedDate.year}";
      });
    }
  }
  // Helper function to convert month number to name
  String _getMonthName(int month) {
    const List<String> months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }



  //===============================> Show Clock Function <=======================
  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onSurface: Colors.black,
              ),
              buttonTheme: ButtonThemeData(
                buttonColor: Colors.black,
              ),
              dialogBackgroundColor: AppColors.borderColor),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        final hours = pickedTime.hour % 12 == 0 ? 12 : pickedTime.hour % 12;
        final minutes = pickedTime.minute.toString().padLeft(2, '0');
        final period = pickedTime.period == DayPeriod.am ? 'AM' : 'PM';
        time.value = "${hours.toString().padLeft(2, '0')}:$minutes $period";
      });
    }
  }
}
