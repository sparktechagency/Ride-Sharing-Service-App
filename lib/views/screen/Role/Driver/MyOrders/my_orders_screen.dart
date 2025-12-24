import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ride_sharing/utils/app_colors.dart';

import '../../../../../controllers/driver_status_ride_controller.dart';
import '../../../../base/custom_text.dart';
import '../BottomNavBar/driver_bottom_menu..dart';
import 'InnerWidget/pending_tab.dart';
import 'InnerWidget/completed_tab.dart';
import 'InnerWidget/current_trips_tab.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final DriverStatusRidesController controller =
  Get.put(DriverStatusRidesController());


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initial fetch (Current Trips = open)
    controller.fetchRidesByStatus("pending");

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      setState(() {});
      if (_tabController.index == 0) {
        controller.fetchRidesByStatus("pending");
      } else if (_tabController.index == 1) {
        controller.fetchRidesByStatus("open");
      } else {
        controller.fetchRidesByStatus("complete");
      }
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
        length: 3,
        child: Scaffold(
            bottomNavigationBar: DriverBottomMenu(3),
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

                  //========================> Current Trips Tab <====================
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
                  //========================> Canceled Tab <====================
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
                  //========================> Completed Tab <====================
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
                CompletedTab(),
              ],
            ))

    );
  }
}
