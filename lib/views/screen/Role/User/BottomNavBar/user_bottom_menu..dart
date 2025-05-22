import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../helpers/route.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_icons.dart';

class UserBottomMenu extends StatelessWidget {
  final int menuIndex;

  const UserBottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor : AppColors.greyColor;
  }

  BottomNavigationBarItem getItem(
      String image,
      String title,
      ThemeData theme,
      int index,
      ) {
    bool isSelected = index == menuIndex;
    return BottomNavigationBarItem(
      label: title,
      icon: Column(
        children: [
          Container(
            height: 3.h,
            width: 32.w,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primaryColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1.r),
            ),
          ),
          SizedBox(height: 5.h),
          SvgPicture.asset(
            isSelected
                ? image
                : image.replaceAll(
              'fill',
              'outline',
            ), // Handle filling and outline icons
            height: 24.0,
            width: 24.0,
            color: colorByIndex(theme, index),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(AppIcons.searchHMIcon, 'Search', theme, 0),
      getItem(AppIcons.myRide, 'My Rides', theme, 1),
      getItem(AppIcons.chats, 'Inbox', theme, 2),
      getItem(AppIcons.profile, 'Profile', theme, 3),
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.r),
          topLeft: Radius.circular(20.r),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey[600],
          currentIndex: menuIndex,
          onTap: (value) {
            switch (value) {
              case 0:
                Get.offAndToNamed(AppRoutes.userSearchScreen);
                break;
              case 1:
                Get.offAndToNamed(AppRoutes.myRidesScreen);
                break;
              case 2:
               Get.offAndToNamed(AppRoutes.userInboxScreen);
                break;
              case 3:
                Get.offAndToNamed(AppRoutes.userProfileScreen);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
