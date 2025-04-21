import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../helpers/route.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_icons.dart';

class BottomMenu extends StatelessWidget {
  final int menuIndex;

  const BottomMenu(this.menuIndex, {super.key});

  Color colorByIndex(ThemeData theme, int index) {
    return index == menuIndex ? AppColors.primaryColor : theme.disabledColor;
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
      icon: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: SvgPicture.asset(
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<BottomNavigationBarItem> menuItems = [
      getItem(AppIcons.home, 'Home', theme, 0),
      getItem(AppIcons.postRides, 'Post Rides', theme, 1),
      getItem(AppIcons.chats, 'Chats', theme, 2),
      getItem(AppIcons.myOrder, 'My Orders', theme, 3),
      getItem(AppIcons.profile, 'Profile', theme, 4),
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
                Get.offAndToNamed(AppRoutes.homeScreen);
                break;
              case 1:
                //Get.offAndToNamed(AppRoutes.matchesScreen);
                break;
              case 2:
               // Get.offAndToNamed(AppRoutes.liveStreamScreen);
                break;
              case 3:
                //Get.offAndToNamed(AppRoutes.chatsScreen);
                break;
              case 4:
                Get.offAndToNamed(AppRoutes.profileScreen);
                break;
            }
          },
          items: menuItems,
        ),
      ),
    );
  }
}
