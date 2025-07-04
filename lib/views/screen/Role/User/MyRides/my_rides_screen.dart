import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';
import '../../../../base/custom_text.dart';
import '../BottomNavBar/user_bottom_menu..dart';
import 'InnerWidget/canceled_tab.dart';
import 'InnerWidget/completed_tab.dart';
import 'InnerWidget/current_trips_tab.dart';
import 'InnerWidget/pending_tab.dart';

class MyRidesScreen extends StatefulWidget {
  const MyRidesScreen({super.key});

  @override
  State<MyRidesScreen> createState() => _MyRidesScreenState();
}

class _MyRidesScreenState extends State<MyRidesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(() {});
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            bottomNavigationBar: UserBottomMenu(1),
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              title: CustomText(
                text: "My Rides".tr,
                fontSize: 16.sp,
              ),
              centerTitle: true,
              bottom: TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  //========================> Pending Tab <====================
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 0
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Pending'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Current Trips Tab <====================
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 1
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Current Trips'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Canceled Trips Tab <====================
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 2
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Canceled'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                  //========================> Completed Tab <====================
                  Tab(
                    child: Container(
                      decoration: BoxDecoration(
                        color: _tabController.index == 3
                            ? const Color(0xFFebf9ff)
                            : Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: CustomText(
                          text: 'Completed'.tr,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body:TabBarView(
              controller: _tabController,
              children:  [
                PendingTab(),
                CurrentTripsTab(),
                CanceledTab(),
                CompletedTab(),
              ],
            ))

    );
  }
}
